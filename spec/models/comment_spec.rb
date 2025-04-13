# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  message         :text
#  comentable_type :string           not null
#  comentable_id   :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
