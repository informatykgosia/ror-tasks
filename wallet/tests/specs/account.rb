require_relative '../../lib/account'

describe Account do
  subcject(:account)		{Account.new(currency, balance)}
  let(:currency)		{Struct.new(:shortcut).new(:eur)}
  let(:balance)			{ 50 }
end
