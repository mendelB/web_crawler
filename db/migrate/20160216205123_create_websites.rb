class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.integer :depth_level
      t.string :title

      t.timestamps null: false
    end
  end
end
