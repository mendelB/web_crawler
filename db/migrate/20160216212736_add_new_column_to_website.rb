class AddNewColumnToWebsite < ActiveRecord::Migration
  def change
    add_reference :websites, :webpage, index: true, foreign_key: true
  end
end
