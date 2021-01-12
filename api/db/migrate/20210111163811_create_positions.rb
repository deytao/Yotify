class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.boolean :enabled, null: false, default: true
      t.float :weight, null: false, default: 0
      t.references :company, foreign_key: true
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
