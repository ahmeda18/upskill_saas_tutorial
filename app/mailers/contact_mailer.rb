class ContactMailer < ActionMailer::Base
  default to: 'ahmeda18@hotmail.com'
  
  def contact_email(name, email, body)
    @name = name
    @email = email
    @bod = body
    
    mail(from: email, subject: 'Contact Form Message')
  end
end
