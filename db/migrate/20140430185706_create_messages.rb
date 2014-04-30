class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender
      t.references :recipient
      t.string :subject
      t.text :body
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
