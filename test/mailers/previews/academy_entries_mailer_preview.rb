# Preview all emails at http://localhost:3000/rails/mailers/academy_entries_mailer
class AcademyEntriesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/academy_entries_mailer/new_resource
  def new_resource
    AcademyEntriesMailer.new_resource
  end

  # Preview this email at http://localhost:3000/rails/mailers/academy_entries_mailer/new_series
  def new_series
    AcademyEntriesMailer.new_series
  end

  # Preview this email at http://localhost:3000/rails/mailers/academy_entries_mailer/new_assessment
  def new_assessment
    AcademyEntriesMailer.new_assessment
  end

end
