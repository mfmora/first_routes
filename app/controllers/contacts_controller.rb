class ContactsController < ApplicationController

  def index
    @contacts = Contact.all
    render json: @contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    if @contact
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: 404
    end
  end

  def update
    # find_by -- nil instead of error if id doesn't exist in DB
    # find -- throws error before if statement
    @contact = Contact.find_by(id: params[:id])

    if @contact.nil?
      render json: @contact.errors.full_messages, status: 404
    elsif @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    if @contact.nil?
      render json: @contact.errors.full_messages, status: 404
    elsif @contact.destroy
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
