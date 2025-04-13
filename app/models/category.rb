# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories
  validates :name, presence: true
end
