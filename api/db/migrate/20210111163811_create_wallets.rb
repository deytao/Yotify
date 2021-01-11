class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.boolean :enabled, null: false, default: true
      t.float :rate, null: false, default: 0
      t.references :company, foreign_key: true
      t.references :portfolio, foreign_key: true

      t.timestamps
    end
  end
end
