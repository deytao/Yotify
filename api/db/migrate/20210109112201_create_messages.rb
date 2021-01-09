class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.boolean  "enabled", null: false, default: true
      t.string   "content", null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
