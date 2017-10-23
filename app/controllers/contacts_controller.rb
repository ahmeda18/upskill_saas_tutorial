class ContactsController < ApplicationController
  # Get request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # Post request /contacts
  def create
    # Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save the Contact Object to the database
      if @contact.save
        #Store form fields via paramaters, into variables
        name = params[:contact][:name]
        email = params[:contact][:email]
        body = params[:contact][:comments]
        # Plug variables into the Contact Maller   
        # email method and send email
        ContactMailer.contact_email(name, email, body).deliver
        # Store success message in flash hash
        # and redirect to new action
        flash[:success] = "Message sent."
        redirect_to new_contact_path
      else
        # if Contact Object doesnt save,
        # store errors in flash hash,
        #reidrect to new action
        flash[:danger] = @contact.errors.full_messages.join(", ")
        redirect_to new_contact_path
      end
  end
  private
    # To collect data from form, we need to use
    # strong paramaters and whitelist form fields
    def contact_params
      params.required(:contact).permit(:name, :email, :comments)
    end
end

