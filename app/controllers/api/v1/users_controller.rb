class Api::V1::UsersController < ApplicationController 
  def create 
    user = User.new(user_params)

    if user.save 
      json_response(UserSerializer.new(user), :created)
    else
      render json: user.errors, status: :unprocessable
    end
  end

  def update 
    @user.update!(user_params)
    json_response(UserSerializer.new(@user))
  end

  def destroy 

  end

  private 
    def user_params 
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def find_user 
      @user = User.find_by(email: params[:email])
    end
end