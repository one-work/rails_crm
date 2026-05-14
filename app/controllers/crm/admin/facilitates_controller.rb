module Crm
  class Admin::FacilitatesController < defined?(RailsBench) ? Bench::FacilitatesController : Admin::BaseController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_cart

    private
    def set_cart
      set_cart_with(good_type: 'Bench::Facilitate')
    end

  end
end
