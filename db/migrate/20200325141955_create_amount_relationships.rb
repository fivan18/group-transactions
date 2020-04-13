class CreateAmountRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :amount_relationships do |t|
      t.integer :transaction_id
      t.integer :group_id

      t.timestamps
    end

    add_index :amount_relationships, :transaction_id
    add_foreign_key :amount_relationships, :transactions

    add_index :amount_relationships, :group_id
    add_foreign_key :amount_relationships, :groups
  end
end
