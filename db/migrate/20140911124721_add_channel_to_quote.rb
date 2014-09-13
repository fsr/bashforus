class AddChannelToQuote < ActiveRecord::Migration
  def change
    add_reference :quotes, :channel, index: true
  end
end
