require 'rails_helper'

RSpec.describe 'Transaction creation', type: :feature, js: true do
  feature 'different processes to create a transaction' do
    scenario 'create a transaction no attached to any group' do
      transaction = create(:transaction)
      visit external_transactions_path
      fill_in 'Username', with: transaction.user.username
      fill_in 'Password', with: 'password'
      find('input[type="submit"]').click


      sleep(1)
      find('a[href="/transactions/new?selected_group="]').click
      sleep(1)
      fill_in 'Name', with: 'Another transaction'
      sleep(1)
      fill_in 'Amount', with: '120'
      sleep(1)
      find('input[type="submit"]').click
      sleep(2)
      expect(page).to have_text("Transaction created!")
    end

    scenario 'create a transaction attached to group' do
      transaction = create(:transaction_with_groups)
      visit group_transactions_path
      fill_in 'Username', with: transaction.user.username
      fill_in 'Password', with: 'password'
      find('input[type="submit"]').click


      sleep(1)
      find('a[href="/transactions/new?selected_group="]').click
      sleep(1)
      fill_in 'Name', with: 'Another transaction'
      sleep(1)
      fill_in 'Amount', with: '120'
      sleep(1)
      find(:select).find(:option, transaction.groups.first.name).select_option
      sleep(1)
      find('input[type="submit"]').click
      sleep(2)
      expect(page).to have_text("Transaction created!")
    end

    scenario 'create a transaction with a chosen group' do
      transaction = create(:transaction_with_groups)
      visit group_path(transaction.groups.first)
      fill_in 'Username', with: transaction.user.username
      fill_in 'Password', with: 'password'
      find('input[type="submit"]').click

      sleep(1)
      find("a[href=\"/transactions/new?selected_group=#{transaction.groups.first.id}\"]").click
      sleep(1)
      fill_in 'Name', with: 'Another transaction'
      sleep(1)
      fill_in 'Amount', with: '120'
      sleep(1)
      find('input[type="submit"]').click
      sleep(2)
      expect(page).to have_text("Transaction created!")
    end
  end
end
