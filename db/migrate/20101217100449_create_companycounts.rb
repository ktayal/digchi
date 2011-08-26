class CreateCompanycounts < ActiveRecord::Migration
  def self.up
    create_table :companycounts do |t|
      t.string :company
      t.float :count

      t.timestamps
    end
  end

  def self.down
    drop_table :companycounts
  end
end
