class AddRefnoToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :refno, :string
  end

  def self.down
    remove_column :posts, :refno
  end
end
