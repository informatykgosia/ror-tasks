describe "wallet" do
  include TestHelper

  context "user with EUR and PLN accounts" do
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
