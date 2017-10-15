require 'rails_helper'

RSpec.describe CurrencyRate, type: :model do
  context 'rails validation' do
    it { should validate_presence_of(:rate) }
  end

  before(:all) do
    @online_rate = create(:currency_rate)
  end

  context 'custom validations' do
    it 'only one unforced rate must exist' do
      second_rate = build(:currency_rate)
      expect(second_rate.save).to eq(false)
      expect(second_rate).to have(1).error_on(:is_force)
      end

    it 'only one forced rate must exist' do
      create(:currency_rate, is_force: true, force_until: '06.06.2020 00:00:00')
      second_rate = build(:currency_rate, is_force: true, force_until: '06.06.2021 00:00:00')
      expect(second_rate.save).to eq(false)
      expect(second_rate).to have(1).error_on(:is_force)
    end

    it 'force_until must exist if forced' do
      invalid_rate = build(:currency_rate, is_force: true)
      expect(invalid_rate.save).to eq(false)
      expect(invalid_rate).to have(1).error_on(:force_until)
    end

    it 'force_until must be more then time now' do
      invalid_rate = build(:currency_rate, is_force: true, force_until: 1.days.ago)
      expect(invalid_rate.save).to eq(false)
      expect(invalid_rate).to have(1).error_on(:force_until)
    end
  end

  context 'Classes methods' do
    it '#current_rate must return actual rate' do
      expect(CurrencyRate.current_rate).to eq(@online_rate)
    end

    it '#current_rate must return force_rate' do
      force_rate = create(:currency_rate, is_force: true, force_until: '06.06.2020 00:00:00')
      expect(CurrencyRate.current_rate).to eq(force_rate)
    end
  end
end
