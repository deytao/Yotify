class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.boolean :enabled, null: false, default: true
      t.string :name, null: false
      t.integer :amount, null: false
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
