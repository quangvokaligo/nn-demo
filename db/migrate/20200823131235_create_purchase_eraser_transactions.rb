class CreatePurchaseEraserTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_eraser_transactions do |t|
      t.string :_id, null: false, index: true
      t.bigint :user_id, null: false, index: true
      t.integer :product_type, null: false
      t.integer :status, null: false, default: 0, index: true
      t.decimal :amount, null: false
      t.string :currency, null: false
      t.string :category_code
      t.integer :points, null: false
      t.string :passed_checks, array: true, null: false

      t.timestamps
    end
  end
end
