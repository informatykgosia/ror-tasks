require_relative '../../lib/lib'
require_relative '../../lib/services/lib'

module TestHelper

  def set_balance(accounts)
    @accounts ||= []
    accounts.each do |currency, balance|
      @accounts << Account.new(currency, balance)
    end
  end

  def set_wallet_balance(money)
    @wallet ||= Wallet.new
    @wallet.set_balance(money)
  end

  def find_account(currency)
    @accounts.find{|a| a.currency == currency}
  end


  def supply(money)
    money.each do |currency, amount|
      find_account(currency).supply(amount)
    end
  end

  def get_balance(currency)
    find_account(currency).balance
  end

  def transfer_money_to_accounts
    @accounts = Transfer.from_wallet_to_accounts(@wallet, @accounts)
  end
end
