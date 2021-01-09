class AddCustomerRefToUsers < ActiveRecord::Migration[5.0]
  def up
    add_reference :users, :customer, foreign_key: true
  end
  def down
    remove_reference :users, :customer, foreign_key: true
  end
end
