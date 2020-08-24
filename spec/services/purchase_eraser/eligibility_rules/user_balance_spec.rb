require 'rails_helper'

RSpec.describe PurchaseEraser::EligibilityRules::UserBalance do
  describe '.check' do
    subject { described_class.check(txn) }

    let(:txn) { instance_double(PurchaseEraserTransaction, user_id: 1, points: 1000) }

    before { allow(Pb::Api).to receive(:get_user_balance).with(txn.user_id).and_return api_result }

    context "when api returns error" do
      let(:api_result) { [nil, "Random error"] }

      it { is_expected.to be false }
    end

    context "when api call succeeded" do
      let(:api_result) { [balance, nil] }

      context "when user balance is smaller than txn points" do
        let(:balance) { 999 }

        it { is_expected.to be false }
      end

      context "when user balance is greater than txn points" do
        let(:balance) { 1001 }

        it { is_expected.to be true }
      end
    end
  end
end
