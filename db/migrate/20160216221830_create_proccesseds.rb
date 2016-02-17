class CreateProccesseds < ActiveRecord::Migration
  def change
    create_table :proccesseds do |t|
      t.string :url

      t.timestamps null: false
    end
  end
end
