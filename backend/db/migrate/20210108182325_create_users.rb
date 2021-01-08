class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.boolean :enabled, default: true
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
