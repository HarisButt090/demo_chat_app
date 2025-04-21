class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, foreign_key: { to_table: :users }
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.string :content
      t.string :message_type

      t.timestamps
    end
  end
end
