module Crm
  class Admin::ProductionsController < Factory::Agent::ProductionsController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_cart

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! production_plans: { produce_on: params[:produce_on], scene_id: params[:scene_id] } if params[:produce_on] && params[:scene_id]
      q_params.merge! params.permit(:organ_id, :factory_taxon_id, 'name-like')

      @productions = Factory::Production.includes(:production_plans, :parts, product: [:brand, { logo_attachment: :blob }]).default_where(q_params).default.order(id: :desc).page(params[:page]).per(params[:per])
    end

    private
    def set_cart
      set_cart_with
    end

  end
end
