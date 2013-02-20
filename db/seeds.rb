# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create departments
[ ['Elec Eng & Comp Sci', 'EECS'] ].each do |name, abbrev|
  Department.find_or_create_by_name abbrev

  Faculty.create(:name => "Rebecca Sealfon", :email => "ras2198@columbia.edu")
end

#   Development-specific seeds
if Rails.env == 'development' then
  [ ['Rebecca Sealfon', 'ras2198@columbia.edu']
  ].each do |name, email|
    f = Faculty.find_or_initialize_by_name_and_email(name, email)
    f.save
  end
end

