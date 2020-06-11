class IncomingMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts params[:subject]
    puts params[:plain]
    if (campaign = Campaign.find_by_notification_email(params[:plain]))
      Gift.create_from_email(params[:plain], campaign)
    else
      puts "************* No Campaign found - email will be ignored"
    end
    render inline: 'success', status: 200
  rescue StandardError => e
    puts e
    render inline: 'failed to parse email', status: 500
  end
end
