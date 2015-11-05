class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :chimp_id
      t.integer :list_id

      t.timestamps null: false
    end
  end
end
