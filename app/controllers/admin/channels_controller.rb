class Admin::ChannelsController < ApplicationController
  def edit
  end

  def update
  	respond_to do |format|
		if @channel.update channel_params
			format.html { redirect_to request.referrer }
		else
			format.html { redirect_to request.referrer }
		end
	end
  end

  def membership
  	respond_to do |format|
		if @channel.update channel_membership_params
			format.html { redirect_to request.referrer }
		else
			format.html { redirect_to request.referrer }
		end
	end
  end



  private
  def channel_params
  	params.require(:channel).permit(:name,:subdomain,:is_private,:send_xmpp,:send_boolean,:send_twitter)
  end
  def channel_membership_params
  	params.require(:channel).permit(user_ids:[])
  end
end
