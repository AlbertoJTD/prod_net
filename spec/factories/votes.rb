# == Schema Information
#
# Table name: votes
#
#  id           :bigint           not null, primary key
#  votable_type :string           not null
#  votable_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :product_vote do
    votable { create(:product) }
  end

  factory :comment_vote do
    votable { create(:comment) }
  end
end
