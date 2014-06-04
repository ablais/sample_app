class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:notice] = "Success"
      redirect_to user
      puts "this works" 
    else
      puts "fail email/password"
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
 end

   def destroy
     sign_out
     redirect_to root_url
   end
end
