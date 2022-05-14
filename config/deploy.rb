# frozen_string_literal: true

lock '3.17.0'

server 'krsz.ru', port: 2216, roles: %w[app], primary: true

set :rvm_ruby,        '3.0.0'
set :application,     'raspberry'
set :repo_url,        'git@github.com:dpr0/raspberry.git'
set :linked_files,    fetch(:linked_files, []).push()
set :linked_dirs,     fetch(:linked_dirs, []).push()
set :keep_releases,   5
set :user,            'pi'
set :use_sudo,        false
set :stage,           :production
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}"
set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
set :ruby_string,     "$HOME/.rvm/rubies/ruby-#{fetch(:rvm_ruby)}/bin/ruby exec bundle exec"
set :ssh_options, {
  user: fetch(:user),
  keys: %w[~/.ssh/id_rsa],
  forward_agent: true,
  auth_methods: %w[publickey password],
  port: 2216
}

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts 'WARNING: HEAD is not the same as origin/master'
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
    end
  end

  before :starting, :check_revision
end
