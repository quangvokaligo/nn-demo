class ProcessVisaTransactionWebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook_id)
    return if !(webhook = Webhook.find_by id: webhook_id)
  end
end
