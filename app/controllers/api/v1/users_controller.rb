class Api::V1::UsersController < ApplicationController
  before_action :find_user, only: :destroy

  #can we wrap the login feature into this as well? Does the session get created
  # here or on the front end?
  def create
    user = User.new(user_params)

    if user.save 
      json_response(UserSerializer.new(user), :created)
    else
      json_response(user.errors, :unprocessable_entity)
    end
  end

  def destroy 
    @user.destroy
  end

  private 
    def user_params 
      params.require(:user).permit(:first_name, :last_name, :email)
    end

    def find_user 
      @user = User.find(params[:id])
    end
end