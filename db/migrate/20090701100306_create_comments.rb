class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.integer :page_id
      t.string  :name, :email
      t.text    :description
    end
  end

  def self.down
    drop_table :comments
  end
end
