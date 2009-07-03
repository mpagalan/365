class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.text :description
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.datetime :published_on
      t.string :image_credits
      t.string :image_taken_in
      t.string :music_credits
      t.string :music_file_name
      t.string :music_content_type
      t.integer :music_file_size
      t.datetime :music_updated_at

      t.timestamps
    end

    add_index :pages, [:published_on, :title], :unique => true, :name => :by_published_on
  end

  def self.down
    remove_index :pages, :name => :by_published_on
    drop_table :pages
  end
end
