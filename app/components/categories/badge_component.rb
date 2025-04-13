# frozen_string_literal: true

class Categories::BadgeComponent < ApplicationComponent
  def initialize(name:, **options)
    @name = name
    @style = options[:style] || 'absolute top-0 right-0 mt-4 mr-4 text-xs text-white px-2 py-1 font-semibold bg-gray-600 bg-opacity-100 rounded-md uppercase'
  end
end
