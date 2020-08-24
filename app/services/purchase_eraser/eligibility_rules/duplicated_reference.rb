module PurchaseEraser::EligibilityRules::DuplicatedReference
  def self.check(txn)
    PurchaseEraserTransaction
      .where(_id: txn._id)
      .where(status: %i[redeemed])
      .empty?
  end
end
