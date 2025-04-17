# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  message         :text             not null
#  comentable_type :string           not null
#  comentable_id   :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.paragraph }
    comentable { create(:product) }
  end
end
