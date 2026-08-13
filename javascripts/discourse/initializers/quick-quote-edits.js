import { action } from "@ember/object";
import { apiInitializer } from "discourse/lib/api";

function collapseParagraphBreaks(content) {
  for (const paragraph of content.querySelectorAll("p")) {
    paragraph.replaceWith(...paragraph.childNodes, " ");
  }
}

function prepareQuoteHtml(cooked) {
  const template = document.createElement("template");
  template.innerHTML = cooked;

  if (settings.quick_quote_remove_prior_quotes) {
    template.content
      .querySelectorAll("aside.quote")
      .forEach((quote) => quote.remove());
  }

  if (settings.quick_quote_remove_links) {
    template.content.querySelectorAll("a").forEach((link) => link.remove());
  }

  if (settings.quick_quote_remove_contiguous_new_lines) {
    collapseParagraphBreaks(template.content);
  }

  const text = template.content.textContent?.trim() ?? "";
  const characterLimit = settings.quick_quote_character_limit;

  if (characterLimit > 0 && text.length > characterLimit) {
    const excerpt = document.createElement("div");
    excerpt.textContent = `...${text.slice(-characterLimit)}`;
    return excerpt.innerHTML;
  }

  return template.innerHTML;
}

export default apiInitializer((api) => {
  api.modifyClass(
    "controller:topic",
    (Superclass) =>
      class extends Superclass {
        @action
        replyToPost(post) {
          const topic = post?.topic ?? this.model;
          const postStream = this.model?.postStream;
          const quoteState = this.quoteState;
          const distanceFromEnd =
            topic?.highest_post_number + 1 - post?.post_number;

          if (
            postStream &&
            topic?.details?.can_create_post &&
            quoteState.postId === null &&
            distanceFromEnd > settings.quick_quote_post_location_threshold
          ) {
            const quoteHtml = prepareQuoteHtml(post.cooked);
            quoteState.selected(post.id, null, {}, quoteHtml, post.cooked);
          }

          return super.replyToPost(post);
        }
      }
  );
});
