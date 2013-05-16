require_relative './test_helper'

describe "wallet" do
  include TestHelper

  context "user with EUR and PLN accounts" do
    specify "supply arbitraty amount of money" do
      set_balance eur: 50, pln: 25
      supply eur:25, pln:30
      
      get_balance(:eur).should == 75
      get_balance(:pln).should == 55
    end

    specify "transfer all money from wallet to accounts" do
      set_wallet_balance eur: 10, pln: 30
      set_balance eur: 0, pln: 0
      transfer_money_to_accounts
      get_wallet_balance(:eur).should == 0
      get_wallet_balance(:pln).should == 0
      get_balance(:eur).should == 10
      get_balance(:pln).should == 30
    end
 
    specify "conversion from EUR to PLN without limit" do
      set_balance :eur => 100, :pln => 0
      set_exchange_rate [:eur,:pln] => 4.15
      convert_money(:eur,:pln)
      get_balance(:eur).should == 0
      get_balance(:pln).should == 415
    end

    specify "conversion from EUR to PLN with limit set to 50" do
      set_balance :eur => 100, :pln => 0
      set_exchange_rate [:eur,:pln] => 4.15
      convert_money_with_limit(:eur,:pln,50)
      get_balance(:eur).should == 50
      get_balance(:pln).should == 205.75
    end
  end
end
