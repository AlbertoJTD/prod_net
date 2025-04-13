# == Schema Information
#
# Table name: product_categories
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :product_category do
    association :product
    association :category
  end
end
