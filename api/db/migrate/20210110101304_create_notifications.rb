class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.boolean :enabled, null: false, default: true
      t.datetime :sent_at, null: false
      t.datetime :read_at
      t.references :message, foreign_key: true, null: false
      t.references :customer, foreign_key: true, null: false

      t.timestamps
    end
  end
end
