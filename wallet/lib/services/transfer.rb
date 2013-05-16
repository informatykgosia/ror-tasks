require_relative '../lib'

class Transfer

  def self.from_wallet_to_accounts(wallet, accounts, money = {})
    new_pockets = {}
    new_accounts = {}
    accounts.each { |a| new_accounts[a.currency] = a }

    if money.empty?
      wallet.pockets.each do |currency, amount|
	new_pockets[currency] = 0
	account = Account.find_or_create(currency, accounts).supply(amount)
	new_accounts[account.currency]=account
      end
      wallet.set_balance(new_pockets)
    else
      money.each do |currency, amount|
      end
      end
  end
end
