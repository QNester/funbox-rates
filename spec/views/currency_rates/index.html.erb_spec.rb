require 'rails_helper'

RSpec.describe "currency_rates/index", type: :view do
  before(:each) do
    assign(:currency_rates, [
      CurrencyRate.create!(),
      CurrencyRate.create!()
    ])
  end

  it "renders a list of currency_rates" do
    render
  end
end
