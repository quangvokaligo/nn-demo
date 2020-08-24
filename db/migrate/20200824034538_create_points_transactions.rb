class CreatePointsTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :points_transactions do |t|
      t.string :source_id

      t.timestamps
    end
  end
end
