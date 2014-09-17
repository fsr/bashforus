class AddUserToLike < ActiveRecord::Migration
  def change
    add_reference :likes, :user, index: true
  end
end
