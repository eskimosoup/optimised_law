class ApplicationMailer < ActionMailer::Base
  default from: "#{SITE_SETTINGS['From Name']} <#{SITE_SETTINGS['Email']}>"
  default to: SITE_SETTINGS['Email']
  layout 'mailer'
end
