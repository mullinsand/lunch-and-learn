class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.string :country
      t.string :recipe_link
      t.string :recipe_title

      t.timestamps
    end
  end
end
