class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.string :chimp_id
      t.string :from_name
      t.string :from_email

      t.timestamps null: false
    end
  end
end
