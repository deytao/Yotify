class MessageContent < ActiveRecord::Migration[5.0]
  def up
    rename_column :messages, :content, :body
    add_column :messages, :subject, :string
  end
  def down
    rename_column :messages, :body, :content
    drop_column :messages, :subject
  end
end
