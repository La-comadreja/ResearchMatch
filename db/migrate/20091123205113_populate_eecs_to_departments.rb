class PopulateEecsToDepartments < ActiveRecord::Migration
  def self.up
    Department.create :name => "College of Staten Island (CUNY)"
    Department.create :name => "Columbia University"
    Department.create :name => "New York University"
    Department.create :name => "Startups - NYC"
  end

  def self.down
    Department.find_by_name(:first, "EECS").each { |d| d.destroy }
  end
end
