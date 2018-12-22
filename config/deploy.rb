# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'raspberry'
set :repo_url, 'git@github.com:dpr0/raspberry.git'
set :deploy_to, '/home/pi/raspberry'
set :deploy_user, 'pi'
set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      #execute :touch, release_path.join('tmp/restart.txt')
      invoke 'unicorn:restart'
    end
  end
  after :publishing, :restart
end
