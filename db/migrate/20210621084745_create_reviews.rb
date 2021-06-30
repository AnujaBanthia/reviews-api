class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.references :reviewable, polymorphic: true
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
