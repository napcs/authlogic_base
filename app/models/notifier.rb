#=Notifier
# The notifier is our mailer class that sends out all of the messages.
class Notifier < ActionMailer::Base
  default_url_options[:host] = WEB_HOST
  
  # Sent when a user requests a password reset.
  # Contains the link they follow back to the site with their token
  # so they can reset the password
  def password_reset_instructions(user)
    subject       "YOUR_APP Password Reset Instructions"
    from          "YOUR_APP <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  # Sent when a user first signs up
  # Contains a link back to the site which verifies the email
  # and then allows the user to set their password
  def activation_instructions(user)
    subject       "Please activate your YOUR_APP account"
    from          "YOUR_APP <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => register_url(user.perishable_token)
  end
  
  # Sent when a user's account activation is completed.
  def activation_confirmation(user)
    subject       "YOUR_APP Activation complete"
    from          "YOUR_APP <noreply@example.com>"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end
  

end