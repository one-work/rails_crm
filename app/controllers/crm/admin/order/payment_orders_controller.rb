module Crm
  class Admin::Order::PaymentOrdersController < Trade::Admin::Order::PaymentOrdersController
    include Controller::Admin
    before_action :set_common_maintain

  end
end
