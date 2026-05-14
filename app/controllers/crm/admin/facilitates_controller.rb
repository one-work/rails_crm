module Crm
  class Admin::FacilitatesController < Bench::Admin::FacilitatesController
    include Controller::Admin
    before_action :set_common_maintain
    before_action :set_cart

    private
    def set_cart
      set_cart_with(good_type: 'Bench::Facilitate')
    end

  end
end if defined? RailsBench
