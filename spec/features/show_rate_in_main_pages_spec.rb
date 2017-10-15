require 'rails_helper'

RSpec.feature 'Show rate in main pages', type: :feature do
  describe 'show actual rate in main page' do
    it 'find rate info', js: true do
      visit('/')
      text = page.first('#current-rate').text
      expect(text).to include('₽')
      expect(text.length).to eq(6)
    end

    it 'link go to admin', js: true do
      visit('/')
      page.first('a').click
      expect(page).to have_current_path('/admin')
    end
  end
end
