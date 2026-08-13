# frozen_string_literal: true

module PageObjects
  module Components
    class QuickQuoteComposer < Composer
      def has_quote?(text)
        has_css?("#reply-control .d-editor-preview aside.quote blockquote", text:)
      end

      def has_no_quote?
        has_no_css?("#reply-control .d-editor-preview aside.quote")
      end

      def has_no_quote_content?(text)
        has_no_css?("#reply-control .d-editor-preview aside.quote blockquote", text:)
      end

      def has_quote_paragraphs?(count:)
        has_css?("#reply-control .d-editor-preview aside.quote blockquote p", count:)
      end

      def has_quote_without_trailing_whitespace?
        within("#reply-control") { has_field?(class: "d-editor-input", with: %r{\S\n\[/quote\]}) }
      end
    end
  end
end
