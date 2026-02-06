module Crm
  module Ext::Maintainable
    extend ActiveSupport::Concern

    included do
      belongs_to :maintain, class_name: 'Crm::Maintain', optional: true, foreign_key: [:contact_id, :agent_id], primary_key: [:contact_id, :agent_id]

      belongs_to :client, class_name: 'Crm::Client', optional: true
      accepts_nested_attributes_for :client

      belongs_to :contact, class_name: 'Crm::Contact', optional: true
      accepts_nested_attributes_for :contact

      has_one :client_contact, class_name: 'Crm::Contact', primary_key: [:user_id, :organ_id], foreign_key: [:client_user_id, :organ_id]

      belongs_to :agent, class_name: 'Org::Member', optional: true

      #before_save :sync_from_maintain, if: -> { client_id.present? && maintain_id_changed? }
      before_validation :sync_from_contact, if: -> { (changes.keys & ['contact_id']).present? || user_id.present? }
      before_validation :sync_from_client, if: -> { (changes.keys & ['client_id']).present? }
      after_save_commit :sync_with_client_contact!, if: -> { contact_id.blank? && user_id.present? } # ！联合主键的 has_one 未存储查不出来，这个是 Rails 的 bug

      #after_create :change_maintain_state, if: -> { maintain_id.present? && saved_change_to_maintain_id? }
    end

    def crm_route_options
      {
        contact_id: contact_id,
        client_id: client_id
      }.compact
    end

    def sync_from_maintain
      return unless maintain
      self.user_id = client.user_id
      #self.member_id = client.client_member_id
    end

    def sync_from_contact
      return unless contact
      self.assign_attributes contact.client_options
    end

    def sync_with_client_contact!
      client_contact || create_client_contact
    end

    def sync_from_client
      return unless client
      self.member_organ_id = client.client_organ_id
    end

    def change_maintain_state
      return unless maintain
      maintain.update state: 'ordered'
    end

  end
end
