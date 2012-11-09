require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "parental_consent_confirmation" do
    mail = Notifier.parental_consent_confirmation
    assert_equal "Parental consent confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
