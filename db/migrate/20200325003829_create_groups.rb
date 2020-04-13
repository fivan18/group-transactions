class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :name, null: false, default: ""

      t.timestamps null: false
    end

    add_index :groups, :user_id
    add_foreign_key :groups, :users
  end
end
