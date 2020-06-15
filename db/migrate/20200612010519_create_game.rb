class CreateGame < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :console
      t.string :hltb
      t.string :genre
      t.string :status
      t.integer :user_id
    end
  end
end
