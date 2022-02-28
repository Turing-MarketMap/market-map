class Api::V1::UsersController < ApplicationController

  #can we wrap the login feature into this as well? Does the session get created
  # here or on the front end?
  def create
    user = User.find_or_create_by(user_params)

    if user.save
      json_response(UserSerializer.new(user), :ok)
    else
      json_response(user.errors, :unprocessable_entity)
    end
  end

  def destroy 
    user = User.find(params[:id])
    user.destroy
  end

  private 
    def user_params 
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end