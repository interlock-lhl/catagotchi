class Cats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.references :user
      t.string :name
      t.datetime :last_fed, null: false
      t.datetime :last_pet, null: false
      t.datetime :last_play, null: false
      t.timestamps null: false
    end
  end
end
