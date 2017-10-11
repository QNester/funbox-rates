require 'rails_helper'

RSpec.describe "currency_rates/edit", type: :view do
  before(:each) do
    @currency_rate = assign(:currency_rate, CurrencyRate.create!())
  end

  it "renders the edit currency_rate form" do
    render

    assert_select "form[action=?][method=?]", currency_rate_path(@currency_rate), "post" do
    end
  end
end
