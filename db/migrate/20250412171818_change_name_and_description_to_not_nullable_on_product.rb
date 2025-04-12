class ChangeNameAndDescriptionToNotNullableOnProduct < ActiveRecord::Migration[7.1]
  def change
    change_column_null :products, :name, false
    change_column_null :products, :description, false
  end
end
