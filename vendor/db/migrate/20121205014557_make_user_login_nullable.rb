class MakeUserLoginNullable < ActiveRecord::Migration

  def self.up
    change_table :users do |t|
      t.change :login, :string, :null => true
    end
  end

  def self.down
    change_table :users do |t|
      t.change :login, :string, :null => false
    end
  end

end
