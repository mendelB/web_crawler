class AddNewColumnToWebpage < ActiveRecord::Migration
  def change
    add_column :webpages, :title, :string
  end
end
