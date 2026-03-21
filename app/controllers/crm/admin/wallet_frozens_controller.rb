module Crm
  class Admin::WalletFrozensController < Trade::Admin::WalletAdvancesController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_wallet
    before_action :set_wallet_frozen, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_wallet_frozen, only: [:new, :create]

    private
    def set_wallet
      @wallet = @client.wallets.find params[:wallet_id]
    end

  end
end
