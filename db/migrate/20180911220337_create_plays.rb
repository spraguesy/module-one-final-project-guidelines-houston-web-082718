class CreatePlays < ActiveRecord::Migration[5.0]
  def change
    create_table :plays do |t|
      t.belongs_to :user
      t.belongs_to :song
  end
end 
end
