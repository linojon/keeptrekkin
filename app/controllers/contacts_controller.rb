class ContactsController < ApplicationController
  skip_after_action :verify_authorized

  def new
    save_back
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash[:notice] = 'Thank you for your message. We will contact you soon!'
      redirect_to saved_back_path
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end
end