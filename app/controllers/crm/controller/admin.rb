module Crm
  module Controller::Admin
    extend ActiveSupport::Concern
    include Controller::Application

    private
    def set_common_maintain
      if params[:client_id]
        @client = Client.default_where(default_ancestors_params).find params[:client_id]
      elsif params[:contact_id]
        @client = Contact.default_where(default_ancestors_params).find params[:contact_id]
      elsif params[:client_member_id]
        @client = Org::Member.where.associated(:client_maintains).where(client_maintains: { organ_id: current_organ.id }).find params[:client_member_id]
      elsif params[:client_organ_id]
        @client = Org::Organ.where.associated(:client_maintains).where(client_maintains: { organ_id: current_organ.id }).find params[:client_organ_id]
      elsif params[:maintain_id]
        @client = Maintain.default_where(default_ancestors_params).find params[:maintain_id]
      else
      end
    end

    def set_cart_with(**options)
      if params[:client_member_id]
        options.merge! member_id: @client.id
      elsif params[:client_id]
        options.merge! client_id: @client.id, contact_id: nil
      elsif params[:contact_id]
        options.merge! client_id: @client.client_id, contact_id: @client.id
      elsif params[:maintain_id]
        options.merge! client_id: @client.client_id, contact_id: @client.contact_id, agent_id: @client.member_id
      end

      @cart = Trade::Cart.get_cart(params, agent_id: current_member.id, **default_params, **options)
    end

  end
end
