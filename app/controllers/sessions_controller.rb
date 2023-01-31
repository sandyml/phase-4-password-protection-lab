class SessionsController < ApplicationController

 # def create
 #  user = User.find_by(username: params[:username])
 #  if user&.authenticate(params[:password])
 #   session[:user_id] ||= user.id
 #   render json: user, status: :okay
 #  else
 #   render json: { error: "Username/Password not found" }, status: :unauthorized
 #  end
 # end

 def create
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password]) 
  # if user&.authenticate(params[:password])
    session[:user_id] ||= user.id
    render json: user, status: :ok
  else
    render json: { error: "Username/Password not found! Please try again!" }, status: :unauthorized
  end
 end

 def destroy
   session.destroy
   render status: :no_content
 end

 # private

 # def params
  
 # end

end

# Create a Sessions controller with a create action for logging in that responds to a POST /login request, and a destroy action for logging out that responds to a DELETE /logout request.