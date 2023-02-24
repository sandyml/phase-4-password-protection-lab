# class SessionsController < ApplicationController

#  def create
#   user = User.find_by(username: params[:username])
#   if user&.authenticate(params[:password])
#     session[:user_id] = user.id
#     render json: user, status: :ok
#   else
#     render json: { error: "Username/Password not found! Please try again!" }, status: :unauthorized
#   end
#  end

#  def destroy
#    session.destroy
#    render status: :no_content
#  end

# end


class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
    session[:user_id] = user.id
    render json: user, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end