require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProductsHelper. For example:
#
# describe ProductsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProductsHelper, type: :helper do
  describe '#simple_description' do
    it 'truncates the description to the specified length' do
      description = 'This is a very long description that should be truncated'
      expect(helper.simple_description(description, 20)).to eq('This is a very lo...')
    end

    it 'uses default length of 100 if not specified' do
      description = 'a' * 150
      expect(helper.simple_description(description).length).to eq(100) # 100 chars + '...'
    end
  end

  describe '#date_format' do
    let(:date) { Date.new(2025, 1, 1) }

    context 'with English locale' do
      around do |example|
        I18n.with_locale(:en) { example.run }
      end

      it 'returns the date in the default format' do
        expect(helper.date_format(date)).to eq('01/01/2025')
      end

      it 'returns the date in short format' do
        expect(helper.date_format(date, format: :short)).to eq('01 Jan')
      end

      it 'returns the date in long format' do
        expect(helper.date_format(date, format: :long)).to eq('January 01, 2025')
      end
    end

    context 'with Spanish locale' do
      around do |example|
        I18n.with_locale(:es) { example.run }
      end

      it 'returns the date in the default format' do
        expect(helper.date_format(date)).to eq('1/1/2025')
      end

      it 'returns the date in short format' do
        expect(helper.date_format(date, format: :short)).to eq('1 de ene')
      end

      it 'returns the date in long format' do
        expect(helper.date_format(date, format: :long)).to eq('1 de enero de 2025')
      end
    end
  end
end
