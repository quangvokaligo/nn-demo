class AddPointsTransactionIdToPurchaseEraserTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :purchase_eraser_transactions, :points_transaction, foreign_key: true
  end
end
