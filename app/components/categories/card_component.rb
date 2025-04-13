# frozen_string_literal: true

class Categories::CardComponent < ApplicationComponent
  def initialize(category:)
    @category = category
  end
end
