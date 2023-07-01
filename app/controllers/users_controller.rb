class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def index 
    users = User.all
    render json: users
  end

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created #, include: :recipes
  end

  def show
   
    if session.include? :user_id
      user = User.find(session[:user_id])
      render json: user
    else
      render json: { errors: "Invalid username or password " }, status: :unauthorized
    end
  end

  private

  def render_not_found_response
    render json: { error: "User not Found" }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end
end
