class AddStateToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :state, :string
  end
end
