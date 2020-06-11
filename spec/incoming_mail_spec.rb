require 'spec_helper'

describe 'incoming mail', type: :request do
  let!(:campaign) do
    Campaign.create(
      slug: 'slug-string', name: 'name', goal: 6000, sustainer_form_id: "123",
      one_time_form_id: '456', greeting: 'hello'
    )
  end

  def body(form_name, amount, transaction_id)
    "Notification of transaction\n\n"\
    "<https://s21aeml01blkbsa02.blob.core.windows.net/transactionalemailimages/p-pfJFr4mVUUaa236IU4z_"\
    "rQ/E52D2823-58ED-4B06-AEE6-C1DADD1EE958/1/00085060-4CBF-45FD-B726-23B182CD8F0C-300x46.png>\n<p>\n"\
    "    You are being notified that an online gift has been made through the #{form_name} donation form.\n"\
    "    If you would like to stop receiving notifications for this donation form, please contact your Blackbaud admin.\n"\
    "</p>\n<p>\n<div style=\"color: #686c73; font-size: 19px; margin-bottom: 5px;\">\n    Gift details\n</div>\n"\
    "<b>Amount:</b> #{amount}<br>\n<b>Transaction ID:</b> #{transaction_id}<br>\n"
  end

  it "accept a sustaining donation email" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: { plain: body("#{campaign.slug}-sustainer", '$60.00', transaction_id) }
    expect(Gift.count).to eq(1)
    expect(Gift.first.attributes.symbolize_keys)
      .to include(amount: 60.00, campaign_id: campaign.id, one_time: false, transaction_id: transaction_id)
    expect(Gift.first.annual_amount).to eq(60 * 12)
  end

  it "accept a one time donation email" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: { plain: body("#{campaign.slug}-one-time", '$60.00', transaction_id) }
    expect(Gift.count).to eq(1)
    expect(Gift.first.attributes.symbolize_keys)
      .to include(amount: 60.00, campaign_id: campaign.id, one_time: true, transaction_id: transaction_id)
    expect(Gift.first.annual_amount).to eq(60)
  end

  it "fails if the slug does not match" do
    transaction_id = 'a4a4ab1a-dfc7-494c-b51c-6ff759c1d244'
    post '/incoming_messages',
         params: { plain: body("x#{campaign.slug}x-one-time", '$60.00', transaction_id) }
    expect(Gift.count).to eq(0)
  end
end
