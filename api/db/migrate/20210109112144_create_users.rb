class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.boolean :enabled, null: false, default: true
      t.string :firstname, null: false
      t.string :lastname, null: false

      t.timestamps
    end
  end
end
