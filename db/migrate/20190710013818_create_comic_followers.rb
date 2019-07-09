class CreateComicFollowers < ActiveRecord::Migration[5.2]
  def change
    create_table :comic_followers do |t|

      t.timestamps
    end
  end
end
