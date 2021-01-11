class CreateCompanies < ActiveRecord::Migration[5.2]
  def up
    create_table :companies do |t|
      t.boolean :enabled, null: false, default: true
      t.string :name
      t.string :ticker

      t.timestamps
    end
  end
end
