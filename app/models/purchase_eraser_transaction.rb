class PurchaseEraserTransaction < ApplicationRecord
  PRODUCT_RATES = {
    on_demand: 1.25,
    auto: 0.75
  }
  SUPPORTED_CURRENCIES = %w[AUD USD]
  SUPPORTED_CATEGORIES = %w[NCPC ASDF]

  enum product_type: %i[on_demand auto]
  enum status: %i[to_be_confirmed redeemed refunded]

  validates :_id, presence: true
  validates :user_id, presence: true
  validates :product_type, presence: true
  validates :status, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :currency, presence: true, inclusion: { in: SUPPORTED_CURRENCIES }
  validates :category_code, inclusion: { in: SUPPORTED_CATEGORIES }
  validates :points, numericality: { greater_than: 0, only_integer: true }

  def self.build_and_validate(**args)
    if !(rate = find_rate_for(args[:product_type]))
      return [nil, "Rate not found for product type #{args[:product_type]}"]
    end

    txn = new(**args).tap { |t| t.points = Integer(t.amount*rate.ceil) }
    [txn, txn.valid? ? nil : txn.errors.full_messages]
  end

  private

  # Simulate ProductRate.find_by!(product_type:)
  def self.find_rate_for(product)
    PRODUCT_RATES[product]
  end
end
