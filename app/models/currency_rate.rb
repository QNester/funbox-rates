class CurrencyRate < ApplicationRecord
  validates :rate, presence: true
  validates :is_force, inclusion: {in: [true, false]}

  validate :only_one_unforce_rate_exist
  validate :force_until_must_exist_for_force
  validate :force_until_is_valid_date


  # -- Validation methods -- #

  # Invalid if trying create more then one unforce rate
  def only_one_unforce_rate_exist
    if !is_force && self.class.current_online_rate.present?
      errors.add(:rate, :invalid, message: 'You cant add not force rate anymore')
    end
  end

  # Invalid if `force_until` < Time.now and force_until less then
  # any exists force rate
  def force_until_is_valid_date
    if is_force?
      date_cond = CurrencyRate.where('force_until >= ?', force_until).any? ||
                  force_until < Time.now
      if date_cond
        err_msg = 'Your rate expire date must be more then exists' \
                  'rate and more then today'
        errors.add(:force_until, :invalid,  message: err_msg)
      end
    end
  end

  # Invalid when `force_until` not exist with force: true
  def force_until_must_exist_for_force
    if !force_until && is_force
      errors.add(:is_false, :invalid, message: 'You must input expire date')
    end
  end

  # -- Class methods -- #

  def self.current_online_rate
    where(is_force: false)
  end

  def self.current_force_rate
    rates = where('is_force = true AND force_until >= ?', Time.now).order(force_until: :asc)
    rates.first
  end

  def self.current_rate
    current_force_rate || current_online_rate
  end

  # -- Instance methods -- #

  def force?
    is_force
  end

  def expired?
    force_until < Time.now
  end
end
