require 'rails_helper'

RSpec.feature "admin from create rate", type: :feature do
  describe 'rate form exist' do
    it 'form and fields exist', js: true do
      visit('/admin')
      expect(page).to have_selector('form')
      expect(page).to have_selector('form input[type=number]')
      expect(page).to have_selector('form select', count: 5)
      expect(page).to have_selector('form button')
    end

    it 'redirect to root after submit', js: true do
      visit('/admin')
      fill_in 'currency_rate[rate]', with: build(:currency_rate).rate.to_s
      select '2018', from: 'currency_rate[force_until(1i)]'
      select 'October', from: 'currency_rate[force_until(2i)]'
      select '15', from: 'currency_rate[force_until(3i)]'
      select '12', from: 'currency_rate[force_until(4i)]'
      select '00', from: 'currency_rate[force_until(5i)]'
      expect {
        page.first('form button').click
      }.to change(CurrencyRate, :count).by(1)
      expect(page).to have_current_path('/')
    end

    it 'fail submit render new' do
      visit('/admin')
      fill_in 'currency_rate[rate]', with: ''
      page.first('form button').click
      expect(page).to have_selector('form')
    end

    it 'redirect back', js: true do
      visit('/admin')
      page.first('a').click
      expect(page).to have_current_path root_path
    end
  end
end
