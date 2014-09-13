class AddUserToQuote < ActiveRecord::Migration
  def change
    add_reference :quotes, :owner, index: true
  end
end
