class RegistrationsController < Devise::RegistrationsController
  def pushover_test
	  Pushover.notification message: 'hello from #bash', user: current_user.pushover_key if current_user.pushover_key.present?
    respond_to { |f| f.js }
  end
  def xmpp_test
    XmppClient.notification title: 'Hello', message: 'hello from #bash', user: current_user.jabber_id if current_user.jabber_id.present?
    respond_to { |f| f.js }
  end
  def set_color
    current_user.update color: params[:color]
    respond_to { |f| f.js }
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :pushover_key, :jabber_id)
  end
end