namespace :deploy do
  
  task :start, :roles => :app do
    puts "You can not do that"
  end
  
  task :stop, :roles => :app do 
    puts "You can not do that"
  end

  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

end
