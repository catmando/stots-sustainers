class Campaign < ApplicationRecord
  has_many :gifts_internal, foreign_key: "campaign_id", class_name: "Gift"

  attr_accessor :one_time

  class << self
    def overall
      find_by_slug('stots')
    end

    def find_by_notification_email_subject(subject)
      match_data = /^A donation has been made to (.+)-(sustainer|one-time) form$/.match(subject)
      slug       = match_data[1] if match_data
      campaign   = find_by_slug(slug)
      campaign.one_time = (match_data[2] == 'one-time') if campaign
      campaign
    end
  end

  def gifts
    if self == Campaign.overall
      Gift.all
    else
      gifts_internal
    end
  end
end
