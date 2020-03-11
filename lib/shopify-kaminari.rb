# coding: utf-8
# frozen_string_literal: true

require 'kaminari'
require 'shopify_api'

module Shopify
  module Kaminari
    autoload :Collection, 'shopify/kaminari/collection'
    autoload :Helper, 'shopify/kaminari/helper'
    autoload :VERSION, 'shopify/kaminari/version'
  end
end

ActionView::Base.send :include, Shopify::Kaminari::Helper

ShopifyAPI::Base.class_eval do
  # Set the default collection parser.
  self.collection_parser = Shopify::Kaminari::Collection

  # Create the #page method.
  define_singleton_method :"#{Kaminari.config.page_method_name}" do |num = 1|
    all(params: { page: num })
  end
end
