class AddMinimumAmountToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :minimum_amount, :integer, default: 0
  end
end
