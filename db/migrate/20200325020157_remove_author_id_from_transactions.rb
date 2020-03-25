class RemoveAuthorIdFromTransactions < ActiveRecord::Migration[5.2]
  def change
    remove_column :transactions, :author_id, :integer
  end
end
