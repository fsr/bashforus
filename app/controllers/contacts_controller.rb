class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    respond_to do |format|
      format.html
    end
  end
  def create
  	@contact = Contact.new
  	@contact.email = contact_params[:email]
  	@contact.feedback = contact_params[:feedback]
  	ContactMailer.feedback_email(@contact).deliver
    redirect_to root_url
  end
  private
  def contact_params
  	params.require(:contact).permit(:email,:feedback)
  end
end