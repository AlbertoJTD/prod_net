# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string           not null
#  visible     :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#
class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_one_attached :image, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  validates :name, :description, presence: true
  validates :name, length: { minimum: 3, maximum: 200 }

  scope :filter_by_name, ->(query) { where('name ILIKE ?', "%#{query}%") }
end
