require "rails_helper"

RSpec.describe CurrencyRatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/currency_rates").to route_to("currency_rates#index")
    end

    it "routes to #new" do
      expect(:get => "/currency_rates/new").to route_to("currency_rates#new")
    end

    it "routes to #show" do
      expect(:get => "/currency_rates/1").to route_to("currency_rates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/currency_rates/1/edit").to route_to("currency_rates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/currency_rates").to route_to("currency_rates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/currency_rates/1").to route_to("currency_rates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/currency_rates/1").to route_to("currency_rates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/currency_rates/1").to route_to("currency_rates#destroy", :id => "1")
    end

  end
end
