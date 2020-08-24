class Int::PurchaseEraserTransactionsController < ApplicationController
  def show
    render json: PurchaseEraserTransaction.find(params[:id])
  end

  def confirm
    txn = PurchaseEraserTransaction.auto.to_be_confirmed.not_expired.find(params[:id])
    points_activity, err = PurchaseEraser.redeem(txn)

    if err
      render status: 400, json: { errors: err }
    else
      render json: points_activity
    end
  end
end
