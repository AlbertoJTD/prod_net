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
require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  let(:product_category) { FactoryBot.build(:product_category) }
  let(:product) { FactoryBot.build(:product) }
  let(:category) { FactoryBot.build(:category) }

  context 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:category) }
  end

  context 'should be valid' do
    it 'with product and category' do
      expect(product_category).to be_valid
    end
  end
end
