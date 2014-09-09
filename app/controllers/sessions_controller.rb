class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user[:active] == true 
      sign_in user
      flash[:notice] = "Success"
      redirect_to user
      puts "this works" 
    elsif user && user.authenticate(params[:session][:password]) && user[:active] == false
      flash.now[:error] = "User is not Active"
      render 'new'
    else
      puts "fail email/password"
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
 end

   def destroy
     sign_out
     #redirect_to root_url
     redirect_to signin_path
   end
end
