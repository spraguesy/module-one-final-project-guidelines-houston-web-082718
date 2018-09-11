class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |f|
      f.belongs_to :user
      f.belongs_to :playlist
    end 
  end
end
