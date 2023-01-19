desc 'Start the PostgreSQL server'
task :psql do
   sh 'sudo service postgresql start'
end