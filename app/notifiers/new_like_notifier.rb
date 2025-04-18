# To deliver this notification:
#
# NewLikeNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewLikeNotifier < ApplicationNotifierrails 
  required_param :chat
  # Add your delivery methods
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
  deliver_by :ios do |config|
    config.device_tokens = -> {
      recipient.notification_tokes.where(platform: :iOS).pluck(:token)
    }

    config.format = -> {
      apn.alert = "Someone responded in your chat!"
      apn.custom_payload = {
        path: chat_path(params[:chat])
      }
    }

    credentials = Rails.application.credentials.ios

    config.bundle_identifier = credentials.bundle_identifier
    config.key_id = credentials.key_id
    config.team_id = credentials.team_id
    config.apns_key = credentials.apns_key

    config.development = Rails.env.local?
  end
end
