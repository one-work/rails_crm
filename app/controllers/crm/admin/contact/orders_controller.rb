module Crm
  class Admin::Contact::OrdersController < Admin::OrdersController
    before_action :set_client

    private
    def set_client
      @client = Contact.find params[:contact_id]
    end
  end
end
