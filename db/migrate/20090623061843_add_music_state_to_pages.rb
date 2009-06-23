class AddMusicStateToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :music_state, :string
  end

  def self.down
    remove_column :pages, :music_state
  end
end
