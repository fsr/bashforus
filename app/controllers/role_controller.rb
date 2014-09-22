class RoleController < ApplicationController

  before_filter :set_role
  before_filter :set_user

  def grant
    if @channel
      @user.add_role @role, @channel
    else
      @user.add_role @role
    end
    redirect_to admin_users_path
  end

  def revoke
    if @channel
      @user.remove_role @role, @channel
    else
      @user.remove_role @role
    end
    redirect_to admin_users_path
  end

  private

  def set_role
    @role = params[:role]
  end
  def set_user
    @user = User.find params[:user_id]
  end
end
