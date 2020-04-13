class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :author_id
      t.string :name, null: false, default: ""
      t.integer :amount

      t.timestamps null: false
    end

    add_index :transactions, :user_id
    add_foreign_key :transactions, :users
  end
end
