require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build(:product) }

  describe 'new object' do
    it 'starts as visible' do
      expect(product.visible).to be_truthy
    end
  end

  describe 'should be valid' do
    it 'with name present' do
      expect(product).to be_valid
    end
  end

  describe 'should not be valid' do
    it 'without name' do
      product.name = nil
      expect(product).to_not be_valid
    end
  end
end
