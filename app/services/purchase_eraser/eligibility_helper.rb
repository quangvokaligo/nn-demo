module PurchaseEraser
  module EligibilityHelper
    DEFAULT_RULES = [
      EligibilityRules::DuplicatedReference,
      EligibilityRules::UserBalance
    ]

    def self.check_eligibility(txn, rules = DEFAULT_RULES)
      rules.partition { |r| r.check txn }
    end
  end
end
