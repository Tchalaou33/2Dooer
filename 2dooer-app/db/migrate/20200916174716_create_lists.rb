class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t| #'lists' needs to be relected/same in user model has_many's
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
