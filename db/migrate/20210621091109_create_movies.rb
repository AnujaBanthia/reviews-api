class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :director
      t.integer :rating
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
