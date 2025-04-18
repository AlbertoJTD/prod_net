class WelcomeJob < ApplicationJob
  queue_as :default

  def perform
    WelcomeMailer.send_welcome_email.deliver_later
  end
end
