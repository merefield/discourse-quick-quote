# frozen_string_literal: true

require_relative "page_objects/components/quick_quote_composer"

RSpec.describe "Quick quote" do
  let!(:theme) { upload_theme_component }

  fab!(:user, :active_user)
  fab!(:topic) { Fabricate(:topic, user:) }
  fab!(:old_post) { Fabricate(:post, topic:, user:, raw: <<~MARKDOWN) }
        This beginning should be truncated because it is too old.

        [quote="nested-user, post:99, topic:99"]
        Nested quote should be removed.
        [/quote]

        [Linked text should be removed](https://example.com)

        The useful ending stays in the quick quote.
      MARKDOWN
  fab!(:paragraph_post) { Fabricate(:post, topic:, user:, raw: <<~MARKDOWN) }
        The first paragraph keeps its inline **formatting**.

        The second paragraph follows it.
      MARKDOWN
  fab!(:recent_posts) { Fabricate.times(4, :post, topic:, user:) }

  let(:composer) { PageObjects::Components::QuickQuoteComposer.new }
  let(:old_post_component) { PageObjects::Components::Post.new(old_post.post_number) }
  let(:paragraph_post_component) { PageObjects::Components::Post.new(paragraph_post.post_number) }
  let(:recent_post_component) { PageObjects::Components::Post.new(recent_posts.last.post_number) }

  before do
    theme.update_setting(:quick_quote_character_limit, 48)
    theme.save!
    sign_in(user)
  end

  it "lets the user reply to an older post with a concise quote" do
    visit(topic.url)

    old_post_component.reply

    expect(composer).to have_quote("The useful ending stays in the quick quote.")
    expect(composer).to have_no_quote_content("This beginning should be truncated")
    expect(composer).to have_no_quote_content("Nested quote should be removed.")
    expect(composer).to have_no_quote_content("Linked text should be removed")
  end

  it "lets the user reply to a recent post without adding a quote" do
    visit(topic.url)

    recent_post_component.reply

    expect(composer).to be_opened
    expect(composer).to have_no_quote
  end

  it "combines quoted paragraphs when newline removal is enabled" do
    theme.update_setting(:quick_quote_character_limit, 0)
    theme.save!

    visit(topic.url)
    paragraph_post_component.reply

    expect(composer).to have_quote(
      "The first paragraph keeps its inline formatting. The second paragraph follows it.",
    )
    expect(composer).to have_quote_paragraphs(count: 1)
    expect(composer).to have_quote_without_trailing_whitespace
  end

  it "keeps quoted paragraphs separate when newline removal is disabled" do
    theme.update_setting(:quick_quote_character_limit, 0)
    theme.update_setting(:quick_quote_remove_contiguous_new_lines, false)
    theme.save!

    visit(topic.url)
    paragraph_post_component.reply

    expect(composer).to have_quote_paragraphs(count: 2)
  end
end
