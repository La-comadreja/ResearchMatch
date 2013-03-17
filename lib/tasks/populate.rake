namespace :db do
  desc "Erase departments and fill departments as institutions"
  task :populate => :environment do
    Department.delete_all
    Department.create :name => "CUNY - College of Staten Island"
    Department.create :name => "Columbia University"
    Department.create :name => "New York University"
    Department.create :name => "Startups - NYC"
  end
end
