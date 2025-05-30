class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :name
      t.integer :chat_type, null: false, default: 0

      t.timestamps
    end
  end
end
