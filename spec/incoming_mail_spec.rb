require 'spec_helper'

describe 'incoming mail', type: :request do
  let!(:campaign) do
    Campaign.create(
      slug: 'slug-string', name: 'name', goal: 6000, sustainer_form_id: "123",
      one_time_form_id: '456', greeting: 'hello'
    )
  end

  it "accept a sustaining donation email" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: {
           subject: "A donation has been made to #{campaign.slug}-sustainer form",
           plain:   "*Amount:* $60.00\n"\
                    "*Transaction ID:* #{transaction_id}"
         }
    expect(Gift.count).to eq(1)
    expect(Gift.first.attributes.symbolize_keys)
      .to include(amount: 60.00, campaign_id: campaign.id, one_time: false, transaction_id: transaction_id)
    expect(Gift.first.annual_amount).to eq(60 * 12)
  end

  it "accept a one time donation email" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: {
           subject: "A donation has been made to #{campaign.slug}-one-time form",
           plain:   "*Amount:* $60.00\n"\
                    "*Transaction ID:* #{transaction_id}"
         }
    expect(Gift.count).to eq(1)
    expect(Gift.first.attributes.symbolize_keys)
      .to include(amount: 60.00, campaign_id: campaign.id, one_time: true, transaction_id: transaction_id)
    expect(Gift.first.annual_amount).to eq(60)
  end
  
  it "fails if the slug does not match" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: {
           subject: "A donation has been made to x#{campaign.slug}x-one-time form",
           plain:   "*Amount:* $60.00\n"\
                    "*Transaction ID:* #{transaction_id}"
         }
    expect(Gift.count).to eq(0)
  end
end
