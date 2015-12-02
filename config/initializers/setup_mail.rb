if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address:        'smtp.sendgrid.net',
    port:           '2525',
    authentication: :plain,
    user_name:      ENV['SENDGRID_USERNAME'],
    password:       ENV['SENDGRID_PASSWORD'],
    domain:         'heroku.com',
    enable_starttls_auto: true
  }
# elsif Rails.env.development?
#   ActionMailer::Base.delivery_method = :smtp
#   ActionMailer::Base.smtp_settings = {
#     address: 'smtp.gmail.com',
#     port: 587,
#     domain: ENV['GMAIL_DOMAIN'],
#     authentication: 'plain',
#     enable_starttls_auto: true,
#     user_name: ENV['GMAIL_USERNAME'],
#     password: ENV['GMAIL_PASSWORD']
#   }
end
