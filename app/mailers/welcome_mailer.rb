class WelcomeMailer < ApplicationMailer
  default from: 'example@example.com'

  def send_welcome_email
    @current_time = DateTime.now
    mail(to: 'example@example.com', subject: 'Welcome to our app')
  end
end
