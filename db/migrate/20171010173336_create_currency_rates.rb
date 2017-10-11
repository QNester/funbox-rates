class CreateCurrencyRates < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_rates do |t|
      t.float :rate, null: false, comment: 'USD to RUB rate'
      t.boolean :is_force, default: false, comment: 'Force = true if admin create it'
      t.date :force_until, comment: 'Expire date of forced rate'
      t.timestamps
    end
  end
end
