# store your custom template at foo/bar/database.yml.erb
set :template_dir, "config"
#
# example of database template

base: &base
  adapter: sqlite3
  timeout: 5000
development:
  database: <%= shared_path %>/db/development.sqlite3
  <<: *base
test:
  database: <%= shared_path %>/db/test.sqlite3
  <<: *base
production:
  adapter: mysql2
  database: researchmatch_production
  username: <%= user %>
  password: <%= Capistrano::CLI.ui.ask("Enter MySQL database password: ") %>
  encoding: utf8
  timeout: 5000
  
