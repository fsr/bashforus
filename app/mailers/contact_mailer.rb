class ContactMailer < ActionMailer::Base
  default from: "feedback@fsrbash.de"
  def feedback_email(contact)
  	@contact = contact
  	mail(to: 'me@stei.gr', subject: 'Feedback from FSR Bash / HashBash')
  end
end
