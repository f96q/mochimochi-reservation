Chef::Log.info 'Running deploy/before_migrate.rb'

node[:deploy].each do |application, deploy|
  execute 'rake assets:precompile' do
    cwd release_path
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV' => deploy[:rails_env]
  end
end
