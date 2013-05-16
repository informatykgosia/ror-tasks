class Wallet
  attr_reader :pockets

  def initialize(money = {})
    @pockets = {}
    set_balance(money)
  end

  def set_balance(money={})
    money.each do |currency, amount|
      @pockets[currency.to_sym] = amount
    end
  end
  
  def get_balance(currency)
   @pockets[currency.to_sym]
  end

end
