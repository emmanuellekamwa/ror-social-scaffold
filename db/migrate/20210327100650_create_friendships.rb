class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: true
      t.string :confirmed
      t.string :boolean

      t.timestamps
    end
  end
end
