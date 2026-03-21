module Crm
  class Admin::WalletFrozensController < Trade::Admin::WalletFrozensController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_wallet
    before_action :set_wallet_frozen, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_wallet_frozen, only: [:new, :create]

    private
    def set_wallet
      @wallet = @client.wallets.find params[:wallet_id]
    end

    def model_klass
      Trade::WalletFrozen
    end

  end
end
