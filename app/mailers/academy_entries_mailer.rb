class AcademyEntriesMailer < ApplicationMailer
  def new_resource(resource, details)
    @resource = resource
    @details = details

    mail to: @details.email, subject: "#{@resource.title} - #{SITE_SETTINGS['Name']}"
  end

  def new_assessment(details)
    @details = details
    mail subject: "Internet Marketing Asssessment - #{SITE_SETTINGS['Name']}"
  end
end
