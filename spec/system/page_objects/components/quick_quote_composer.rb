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
    end
  end
end
