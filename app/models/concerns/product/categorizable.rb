module Product::Categorizable
  extend ActiveSupport::Concern

  included do
    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories
    accepts_nested_attributes_for :categories
  end
end
