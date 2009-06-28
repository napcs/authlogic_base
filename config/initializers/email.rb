if File.exists? "#{RAILS_ROOT}/config/email.yml"
  c = YAML::load(File.open("#{RAILS_ROOT}/config/email.yml"))

  delivery_method = c[RAILS_ENV]['email']['delivery_method']

  if delivery_method == "sendmail"
     ActionMailer::Base.delivery_method = :sendmail
  elsif delivery_method == "test"
    ActionMailer::Base.delivery_method = :test 
  else
    ActionMailer::Base.delivery_method = :smtp

    ActionMailer::Base.smtp_settings = {
      :tls => true,
      :address  => c[RAILS_ENV]['email']['server'], 
      :port  => c[RAILS_ENV]['email']['port'], 
      :domain => c[RAILS_ENV]['email']['domain'],
      :authentication => c[RAILS_ENV]['email']['authentication'],
      :user_name => c[RAILS_ENV]['email']['username'],
      :password => c[RAILS_ENV]['email']['password']
    }

  end
  SITE_ADMIN_EMAIL = c[RAILS_ENV]['email']['site_admin_email']
  WEB_HOST = c[RAILS_ENV]['web_host']

else

  delivery_method = ENV['RAILS_EMAIL_DELIVERY_METHOD']

  if delivery_method == "sendmail"
     ActionMailer::Base.delivery_method = :sendmail
  elsif delivery_method == "test"
    ActionMailer::Base.delivery_method = :test 
  else
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
      :tls => true,
      :address  => ENV['SMTP_SERVER'], 
      :port  => ENV['SMTP_PORT'], 
      :domain => ENV['SMTP_DOMAIN'],
      :authentication =>ENV['SMTP_AUTHENTICATION'],
      :user_name => ENV['SMTP_USER'],
      :password => ENV['SMTP_PASS']
    }
  end
  SITE_ADMIN_EMAIL = ENV['SITE_ADMIN_EMAIL']
  WEB_HOST = ENV['WEB_HOST']
end
