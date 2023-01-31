class UsersController < ApplicationController
    before_action :authorize, only: [:show]
    # rescue_from ActiveRecord::RecordInvalid, with: :user_data_invalid
    # rescue_from ActiveRecord::RecordNotFound, with: :user_data_not_found

 # def create
 #  new_user = User.create!(user_params)
 #  session[:user_id] ||= new_user.id
 #  render json: new_user, status: :created
 # end

 def create 
  user = User.create(user_params)
   if user.valid? 
    session[:user_id] = user.id
    render json: user, status: :created
   else
    render json: { error: user.errors.full_messages }, status: :unprocessable_entity
   end
 end

 def show
    user = User.find_by(id: session[:user_id])
    render json: user, status: :ok
 end

 private

 def user_params
    params.permit(:username, :password, :password_confirmation)
 end

 def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
 end

 # def user_data_invalid(error_hash)
 #     render json: { errors: error_hash.record.errors.full_messages }, status: :unprocessable_entity
 # end

 # def user_data_not_found
 #     render json: { error: "Please login to view your account page." }, status: :not_found
 # end


end