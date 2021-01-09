class CreateCustomers < ActiveRecord::Migration[5.0]
  def up
    create_table :customers do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.string :contact_email
      t.date :signup_date

      t.timestamps
    end
    add_index :customers, :slug, unique: true
  end
  def down
    drop_table :customers
  end
end
