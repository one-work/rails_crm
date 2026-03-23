module Crm
  class Admin::WalletRefundsController < Trade::Admin::WalletRefundsController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_wallet
    before_action :set_wallet_refund, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_wallet_refund, only: [:new, :create]

    def index
      q_params = {}

      @wallet_refunds = @wallet.wallet_refunds.default_where(q_params).page(params[:page])
    end

    private
    def set_wallet
      @wallet = @client.wallets.find params[:wallet_id]
    end

    def set_new_wallet_refund
      @wallet_refund = @wallet.wallet_refunds.build(wallet_refund_params)
    end

    def set_wallet_refund
      @wallet_refund = @wallet.wallet_refunds.find(params[:id])
    end

    def wallet_refund_params
      params.fetch(:wallet_refund, {}).permit(
        :total_amount,
        :comment
      )
    end

  end
end
