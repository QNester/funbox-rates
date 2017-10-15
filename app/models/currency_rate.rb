class CurrencyRate < ApplicationRecord
  validates :rate, presence: true

  validate :only_one_unforce_rate_exist
  validate :only_one_force_rate_exist
  validate :force_until_must_exist_for_force
  validate :force_until_is_valid_date


  # -- Validation methods -- #

  # Invalid if trying create more then one unforce rate
  def only_one_unforce_rate_exist
    current = self.class.current_online_rate
    if !is_force && current.present?
      if id != current.id
        err_msg = 'You cant add not force rate anymore'
        errors.add(:is_force, :invalid, message: err_msg)
      end
    end
  end

  # Invalid if trying create more then one force rate
  def only_one_force_rate_exist
    current = self.class.current_force_rate
    if is_force && current.present?
      if id != current.id
        err_msg = 'You cant add more then one custom rate'
        errors.add(:is_force, :invalid, message: err_msg)
      end
    end
  end

  # Invalid if `force_until` < Time.now and force_until less then
  # any exists force rate
  def force_until_is_valid_date
    return unless force_until
    if is_force && force_until < Time.now
      err_msg = 'Expire date can not be less then current time'
      errors.add(:force_until, :invalid,  message: err_msg)
    end
  end

  # Invalid when `force_until` not exist with force: true
  def force_until_must_exist_for_force
    if is_force && !force_until
      err_msg = 'You must input expire date'
      errors.add(:force_until, :invalid, message: err_msg)
    end
  end

  # -- Class methods -- #

  def self.current_online_rate
    find_by(is_force: false)
  end

  def self.current_force_rate
    find_by('is_force = ? AND force_until >= ?', true, Time.now)
  end

  def self.current_rate
    current_force_rate || current_online_rate
  end

  # -- Instance methods -- #

  def formated_rate
    sprintf '%.2f',  rate
  end

  def force?
    is_force
  end

  def expired?
    force_until < Time.now
  end
end
