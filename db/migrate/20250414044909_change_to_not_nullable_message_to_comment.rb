class ChangeToNotNullableMessageToComment < ActiveRecord::Migration[7.1]
  def change
    change_column_null :comments, :message, false
  end
end
