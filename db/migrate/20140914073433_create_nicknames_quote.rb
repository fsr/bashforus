class CreateNicknamesQuote < ActiveRecord::Migration
  def change
    create_table :nicknames_quotes do |t|
      t.references :nickname, index: true
      t.references :quote, index: true
    end
  end
end
