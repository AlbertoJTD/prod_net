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
class Comment < ApplicationRecord
  belongs_to :comentable, polymorphic: true
  has_many :votes, as: :votable, dependent: :destroy

  validates :message, presence: true
end
