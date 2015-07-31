require 'test_helper'

class AcademyEntriesMailerTest < ActionMailer::TestCase
  test "new_resource" do
    mail = AcademyEntriesMailer.new_resource
    assert_equal "New resource", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_series" do
    mail = AcademyEntriesMailer.new_series
    assert_equal "New series", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_assessment" do
    mail = AcademyEntriesMailer.new_assessment
    assert_equal "New assessment", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
