class SessionsController < ApplicationController
	def create
		@user = User.find_by(email: params[:email])
		errors = []

		if @user
			if @user.authenticate(params[:password])
				session[:user_id] = @user.id

				return redirect_to '/groups'
			else
				errors << 'Invalid password'
			end
		else
			errors << 'No account with that email exist. Please register first'
		end
		redirect_to :back, alert: errors
	end

	def destroy
		session.delete :user_id if session.key? 'user_id'

		redirect_to ''
	end
end
