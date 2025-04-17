module Product::Searchable
  extend ActiveSupport::Concern

  included do
    scope :filter_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
  end
end
