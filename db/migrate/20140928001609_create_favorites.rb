class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :post, index: true
      t.references :user, index: true

      t.timestamps
    end
    add_index :favorites, :post_id
    add_index :favorites, :user_id
  end
end
