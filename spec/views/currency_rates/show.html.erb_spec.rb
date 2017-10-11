require 'rails_helper'

RSpec.describe "currency_rates/show", type: :view do
  before(:each) do
    @currency_rate = assign(:currency_rate, CurrencyRate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
