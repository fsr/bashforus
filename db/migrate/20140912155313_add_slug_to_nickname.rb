class AddSlugToNickname < ActiveRecord::Migration
  def change
    add_column :nicknames, :slug, :string
    add_index :nicknames, :slug, unique: true
  end
end
