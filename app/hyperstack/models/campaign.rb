class Campaign < ApplicationRecord
  has_many :gifts_internal, foreign_key: "campaign_id", class_name: "Gift"

  attr_accessor :one_time

  class << self
    def overall
      find_by_slug('stots')
    end

    def find_by_notification_email(email_body)
      match_data = /You are being notified that an online gift has been made through the (.+)-(sustainer|one-time) donation form/.match(email_body)
      slug       = match_data[1] if match_data
      campaign   = find_by_slug(slug)
      campaign&.one_time = (match_data[2] == 'one-time')
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
