require 'pb/api'

module PurchaseEraser::EligibilityRules::UserBalance
  def self.check(txn)
    user_balance, err = Pb::Api.get_user_balance(txn.user_id)
    return false if err

    user_balance >= txn.points
  end
end
