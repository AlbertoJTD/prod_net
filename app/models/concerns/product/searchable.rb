module Product::Searchable
  extend ActiveSupport::Concern

  included do
    class << self
      def popular
        joins("LEFT JOIN votes ON votes.votable_id = products.id AND votes.votable_type = 'Product'")
          .select('products.*, COUNT(votes.id) as votes_count')
          .group('products.id')
          .order('votes_count DESC')
      end
    end

    scope :filter_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
    scope :visible, -> { where(visible: true) }
  end
end
