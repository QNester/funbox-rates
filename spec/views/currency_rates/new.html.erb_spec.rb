require 'rails_helper'

RSpec.describe "currency_rates/new", type: :view do
  before(:each) do
    assign(:currency_rate, CurrencyRate.new())
  end

  it "renders new currency_rate form" do
    render

    assert_select "form[action=?][method=?]", currency_rates_path, "post" do
    end
  end
end
