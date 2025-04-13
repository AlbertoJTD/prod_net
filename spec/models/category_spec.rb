# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.build(:category) }

  context 'associations' do
    it { should have_many(:product_categories).dependent(:destroy) }
    it { should have_many(:products).through(:product_categories) }
  end

  context 'should be valid' do
    it 'with name present' do
      expect(category).to be_valid
    end
  end

  context 'should not be valid' do
    it 'without name' do
      category.name = nil
      expect(category).to_not be_valid
    end
  end
end
