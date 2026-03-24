module Crm
  class Admin::PaymentsController < Trade::Admin::PaymentsController
    include Controller::Admin
    before_action :set_common_maintain

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:type, :state, :pay_state, :id, :buyer_identifier, :buyer_bank, :payment_uuid, 'buyer_name-like', 'payment_orders.state', 'orders.uuid')

      set_count(q_params)
      @payments = WalletPayment.includes(:wallet, :payment_method, :payment_orders).where(wallet: { contact_id: @client.id }).default_where(q_params).order(id: :desc).page(params[:page])
    end

  end
end
