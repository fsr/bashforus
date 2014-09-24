class AddSendTwitterToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :send_twitter, :boolean
  end
end
