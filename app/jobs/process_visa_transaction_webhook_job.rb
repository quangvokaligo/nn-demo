require 'gh/api'

class ProcessVisaTransactionWebhookJob < ApplicationJob
  queue_as :default

  def perform(webhook_id)
    return if !(@webhook = Webhook.find_by id: webhook_id)

    @user, err = Gh::Api.find_ext_user(webhook_params["externalUserId"])
    return log_error(err) if err

    @txn, err = PurchaseEraserTransaction.build_and_validate(**transaction_params)
    return log_error(err) if err

    passed_checks, failed_checks = PurchaseEraser::EligibilityHelper.check_eligibility(@txn)
    return log_error("These checks are failed: #{failed_checks.map(&:name)}") if failed_checks.any?

    @txn.update(passed_checks: passed_checks.map(&:name))
    log "Purchase Eraser transaction with id ##{@txn.id} successfuly created"
  end

  private

  def webhook_params
    @webhook_params ||= @webhook
                          .payload
                          .merge(
                            @webhook
                              .payload["messageElementsCollection"]
                              .map { |h| [h["Key"], h["Value"]] }
                              .to_h
                          )
  end

  def transaction_params
    {
      _id: webhook_params["Transaction.TransactionID"],
      product_type: :auto,
      user_id: @user.id,
      amount: webhook_params["Transaction.TransactionAmount"],
      currency: find_currency(webhook_params["Transaction.TransactionCurrencyCode"]),
      category_code: webhook_params["Transaction.TransactionCategoryCode"]
    }
  end

  def base_log
    @base_log ||= "#{self.class.name} id ##{@webhook.id}"
  end

  def log(msg)
    Sidekiq.logger.info "#{base_log}: #{msg}"
  end

  def log_error(err)
    Sidekiq.logger.error "#{base_log}: #{err}"
  end

  def find_currency(iso_code)
    case iso_code
    when "036"
      "AUD"
    end
  end
end
