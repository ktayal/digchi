class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :company
      t.string :city
      t.text :title
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
