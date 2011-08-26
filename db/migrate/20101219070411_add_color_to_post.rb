class AddColorToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :color, :string
  end

  def self.down
    remove_column :posts, :color
  end
end
