module PurchaseEraser::EligibilityRules::DuplicatedReference
  def self.check(txn)
    PurchaseEraserTransaction
      .where(_id: txn._id)
      .where(status: %i[to_be_confirmed redeemed])
      .empty?
  end
end
