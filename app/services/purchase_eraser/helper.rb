require 'pb/api'

module PurchaseEraser
  module Helper
    DEFAULT_RULES = [
      EligibilityRules::DuplicatedReference,
      EligibilityRules::UserBalance
    ]

    def self.check_eligibility(txn, rules = DEFAULT_RULES)
      rules.partition { |r| r.check txn }
    end

    def self.redeem(txn)
      passed_checks, failed_checks = check_eligibility(txn)
      return [nil, "Failed eligibility checks: #{failed_checks.map(&:name)}"] if failed_checks.any?

      points_txn_id, err = Pb::Api.redeem(source_id: txn.id, points: txn.points)
      if err
        txn.redeem_failed!
        return [nil, "Failed to redeem due to PB error: #{err}"]
      end

      points_txn = PointsTransaction.create(source_id: points_txn_id)
      txn.update(status: :redeemed, points_transaction_id: points_txn.id)

      [points_txn, nil]
    end
  end
end
