class UsersController < ApplicationController
  def index
  end

  def create
  	new_user
  	if new_user.valid? 
  		session[:user_id] = new_user.id

  		redirect_to '/groups'
  	else
  		redirect_to :back, alert: new_user.errors.full_messages
  	end
  end


  helper_method def user
  	@User ||= User.find_by(id: params[:id])
  end

  helper_method def new_user
  	@new_user ||= User.create(user_params)
  end

  private 
  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  	end
end
