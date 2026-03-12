module Crm
  class SyncContactJob < ApplicationJob

    def perform(client)
      client.sync_contact_to_maintains
    end

  end
end
