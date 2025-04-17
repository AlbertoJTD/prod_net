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

  include Product::Categorizable
  include Product::Searchable
  include Votable
  include Commentable

  has_one_attached :image, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, length: { minimum: 3, maximum: 200 }
end
