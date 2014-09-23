class AddPushoverKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :pushover_key, :string
  end
end
