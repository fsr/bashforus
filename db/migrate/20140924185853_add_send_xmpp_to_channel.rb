class AddSendXmppToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :send_xmpp, :boolean
  end
end
