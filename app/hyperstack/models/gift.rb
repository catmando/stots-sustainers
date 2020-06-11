class Gift < ApplicationRecord
  belongs_to :campaign
  def self.create_from_email(email_body, campaign)
    match_data      = /^\*Amount:\* \$(.+)$/.match(email_body)
    amount          = match_data[1].to_f
    match_data      = /^\*Transaction ID:\* (.+)$/.match(email_body)
    transaction_id  = match_data[1]
    Gift.create(amount: amount, transaction_id: transaction_id, one_time: campaign.one_time, campaign: campaign)
  end

  def annual_amount
    if one_time
      amount
    else
      amount * 12
    end
  end
end
