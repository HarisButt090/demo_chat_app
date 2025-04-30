class CreateCalls < ActiveRecord::Migration[7.1]
  def change
    create_table :calls do |t|
      t.references :caller, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }

      t.integer :call_type, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.datetime :started_at
      t.datetime :ended_at
      t.integer :duration

      t.timestamps
    end
  end
end
