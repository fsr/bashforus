class CreateNicknames < ActiveRecord::Migration
  def change
    create_table :nicknames do |t|
      t.references :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
