class AddIndexesToMessages < ActiveRecord::Migration
  def change
    add_index :messages, :recipient_id
    add_index :messages, :created_at
  end
end
