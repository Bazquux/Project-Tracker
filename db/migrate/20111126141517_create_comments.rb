class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
			t.integer :ticket_id
			t.integer :user_id
      t.timestamps
    end
    add_index :comments, :ticket_id
    add_index :comments, :user_id
   end
end
