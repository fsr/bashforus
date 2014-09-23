class AddJabberIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :jabber_id, :string
  end
end
