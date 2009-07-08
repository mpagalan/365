class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.integer :page_id
      t.string  :name, :email
      t.text    :description
      t.boolean :is_spam,  :default => false
      t.timestamps
    end
    add_index :comments, [:page_id, :created_at, :is_spam], :name => "page_comemnts"
  end

  def self.down
    drop_table :comments
  end
end
