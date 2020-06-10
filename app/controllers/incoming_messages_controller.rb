class IncomingMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    puts params[:envelope][:to] # print the to field to the logs
    puts params[:subject] # print the subject to the logs
    puts params[:plain] # print the decoded body plain to the logs if present
    puts params[:html] # print the html decoded body to the logs if present
    puts params[:attachments][0] if params[:attachments] # A tempfile attachment if attachments is populated

    # Do some other stuff with the mail message

    render :inline => 'success', :status => 200 # a status of 404 would reject the mail
  end
end
