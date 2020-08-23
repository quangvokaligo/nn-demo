class CreateWebhooks < ActiveRecord::Migration[6.0]
  def change
    create_table :webhooks do |t|
      t.jsonb :payload, null: false

      t.timestamps
    end
  end
end
