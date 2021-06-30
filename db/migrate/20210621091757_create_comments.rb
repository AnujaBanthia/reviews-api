class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.belongs_to :review, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
