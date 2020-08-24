require 'rails_helper'

RSpec.describe "Ext::Webhooks", type: :request do
  subject do
    headers = { "CONTENT_TYPE" => "application/json" }
    post "/ext/webhooks", params: params.to_json, headers: headers
  end

  let(:params) { { "externalUserId" => ext_uid, "messageElementsCollection" => msg } }
  let(:ext_uid) { "6d98bada-e367-11ea-87d0-0242ac130003" }
  let(:msg) do
    [
        {
            "Key" => "Transaction.TransactionID",
            "Value" => "a90502ae-e367-11ea-87d0-0242ac130003"
        },
        {
            "Key" => "Transaction.CurrencyCodeNumeric",
            "Value" => "036"
        },
        {
            "Key" => "Transaction.TransactionAmount",
            "Value" => "10.00"
        },
        {
            "Key" => "Transaction.MerchantCategoryCode",
            "Value" => "NCPC"
        },
        {
            "Key" => "Transaction.VisaMerchantName",
            "Value" => "VMA"
        }
    ]
  end
  let(:db_error) { false }

  context "when params is invalid" do
    before { subject }

    context "when externalUserId is missing" do
      let(:ext_uid) {}

      it { expect(response.status).to eq 400 }
    end

    context "when messageElementsCollection is missing" do
      let(:msg) {}

      it { expect(response.status).to eq 400 }
    end
  end

  context "when params is valid" do
    context "when webhook saved succesfully" do
      it "enqueues ProcessVisaTransactionWebhookJob" do
        allow(ProcessVisaTransactionWebhookJob).to receive(:perform_later)

        subject

        expect(ProcessVisaTransactionWebhookJob).to have_received(:perform_later).with(Webhook.last.id)
      end

      it { expect { subject }.to change { Webhook.count }.by(1) }

      it "returns correct status" do
        subject

        expect(response.status).to eq 201
      end

      it "renders correct data" do
        subject

        expect(response.body).to eq Webhook.last.to_json
      end
    end
  end
end
