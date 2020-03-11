module Shopify
  module Kaminari
    module Helper
      def cursor_paginate(items, options = {})
        return unless items.respond_to?(:cursor_pagination)

        return paginate(items, options) unless items.resource_class.cursor_based?

        res = ["<div class='pagination cursor-based #{options[:pagination_class]}'><span class='button-group'>"]

        additional_params = options.with_indifferent_access[:params] || {}

        if items.cursor_pagination[:previous] || items.cursor_pagination[:next]
          res << link_to(
            '',
            url_for(
              additional_params.merge(
                page_info: @items.cursor_pagination.dig(:previous, :page_info),
                limit: @items.cursor_pagination.dig(:previous, :limit)
              )
            ),
            class: "button secondary icon-arrow-left #{@items.cursor_pagination[:previous].blank? && 'disabled'}"
          )

          res << link_to(
            '',
            url_for(
              additional_params.merge(
                page_info: @items.cursor_pagination.dig(:next, :page_info),
                limit: @items.cursor_pagination.dig(:next, :limit)
              )
            ),
            class: "button secondary icon-arrow-right #{@items.cursor_pagination[:next].blank? && 'disabled'}"
          )
        end

        res << '</span></div>'

        raw res.join(' ')
      end
    end
  end
end
