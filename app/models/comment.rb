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
  include Votable

  belongs_to :comentable, polymorphic: true

  validates :message, presence: true
end
