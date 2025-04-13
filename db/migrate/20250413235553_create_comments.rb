class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :message
      t.references :comentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
