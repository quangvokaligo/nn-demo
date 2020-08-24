class CreatePointsTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :points_transactions do |t|
      t.string :_id

      t.timestamps
    end
  end
end
