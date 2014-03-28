RAILS_ROOT = '/u/apps/photography/current'
PID_PATH = '/u/apps/photography/shared/pids/unicorn.pid'
DELAYED_JOB_WORKERS = 2

set :application, 'photography'
set :repo_url, 'git@github.com:alechoey/photography.git'
set :deploy_to, '/u/apps/photography'

set :rails_env, 'production' #for delayed_job

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# set :deploy_to, '/var/www/my_app'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

set :linked_files, %w{app/views/application/_analytics.html config/database.yml config/paperclip/s3_credentials.yml config/paperclip/paperclip.secret}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

# deploy.rb or stage file (staging.rb, production.rb or else)
set :rvm_type, :user                     # Defaults to: :auto
set :rvm_ruby_version, '2.1.1@global'    # Defaults to: 'default'

namespace :deploy do
  desc 'Start application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within RAILS_ROOT do
        with rails_env: 'production', unicorn_workers: 3 do
          execute :bundle, :exec, "unicorn_rails \
          -c #{File.join(RAILS_ROOT, 'config/deploy/assets/unicorn.rb')} \
          -E production -D"
        end
      end
    end
  end
  
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      with rails_env: 'production' do
        execute "kill -s USR2 `cat #{PID_PATH}`"
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :restart, 'delayed_job:restart'
end