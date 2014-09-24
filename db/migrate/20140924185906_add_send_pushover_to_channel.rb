class AddSendPushoverToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :send_pushover, :boolean
  end
end
