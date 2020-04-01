require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe 'transactions' do
    it 'create external transaction' do
      transaction = create(:transaction)
      sign_in transaction.user
      get :external_transactions
      get :new, params: { selected_group: '' }
      post :create, params: { transaction: { name: 'Another transaction', amount: '120'},
                              group: { group_id: '' } }
      expect(response).to redirect_to(:external_transactions)
    end

    it 'create group transaction' do
      transaction = create(:transaction_with_groups)
      sign_in transaction.user
      get :group_transactions
      get :new, params: { selected_group: '' }
      post :create, params: { transaction: { name: 'Another transaction', amount: '120'},
                              group: { group_id: transaction.groups.first.id } }
      expect(response).to redirect_to(:group_transactions)
    end
  end
end
