namespace :app do
  desc "Start the server in development mode"
  task :run do
    sh 'script/server'
  end
end