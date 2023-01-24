desc 'Start the PostgreSQL server'
task psql: :environment do
  sh 'sudo service postgresql start'
end
