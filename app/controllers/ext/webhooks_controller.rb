class Ext::WebhooksController < ApplicationController
  def create
    webhook = Webhook.new payload: purchase_eraser_webhook_params
    render(status: :bad_request, json: webhook.errors) if !webhook.save

    ProcessVisaTransactionWebhookJob.perform_later webhook.id
    render status: :created, json: webhook
  end

  private

  def purchase_eraser_webhook_params
    params.require(["externalUserId", "messageElementsCollection"])
    params.permit("externalUserId", "messageElementsCollection" => ["Key", "Value"])
  end
end
