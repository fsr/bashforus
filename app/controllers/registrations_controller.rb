class RegistrationsController < Devise::RegistrationsController
  def pushover_test
  	if current_user.pushover_key.present?
	  Pushover.notification message: 'hello from #bash', user: current_user.pushover_key
	end
	respond_to do |format|
	  format.js
	end
  end
  def update
  	update_params = account_update_params
    if update_params[:current_password].blank?
      update_params.delete("current_password")
      update_params.delete("password")
      update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(update_params)
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to request.referrer
    else
      render "edit"
    end
  end

  private
 
  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :pushover_key)
  end
end