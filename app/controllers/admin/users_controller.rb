class Admin::UsersController < ApplicationController
	before_filter :set_user, except: [:new, :create, :index]
  def index
  	@users = User.all
  end

  def show
  end

  def new
  end

  def edit
  end
  private
  def set_user
  	@user = User.find(params[:id])
  end
end
