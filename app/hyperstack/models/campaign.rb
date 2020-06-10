class Campaign < ApplicationRecord
  # has_many :gifts

  has_many :gifts_internal, foreign_key: "campaign_id", class_name: "Gift"

  def self.overall
    find_by_slug('stots-website')
  end

  def gifts
    if self == Campaign.overall
      Gift.all
    else
      gifts_internal
    end
  end
end
