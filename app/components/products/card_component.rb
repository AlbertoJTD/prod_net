# frozen_string_literal: true

class Products::CardComponent < ApplicationComponent
  def initialize(product:, **options)
    @product = product
    @options = options
  end
end
