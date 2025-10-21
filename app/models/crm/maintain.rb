module Crm
  class Maintain < ApplicationRecord
    include Model::Maintain
    include Factory::Ext::Maintain if defined? RailsFactory
    include Wechat::Ext::Maintain if defined? RailsWechat
    include Eventual::Ext::Planned if defined? RailsEvent
  end
end
