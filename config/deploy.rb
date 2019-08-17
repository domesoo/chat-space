# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

# Capistranoのログの表示に利用する
set :application, "chat-space"

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:domesoo/chat-space.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1' #カリキュラム通りに進めた場合、2.5.1か2.3.1です

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCv9wR9PM34b/bZJBDaZBBG/cyhFo4uoA62tESFx/34vHC7fFntgy58VdMAn5tv7NTQ5r3TTxXcLCrHV8fHsqJNIiUqKUSN3ow5ssrdxjxPaEh5N84WhWFWxqswIMAjabNFAFJeYkgbjhNelXmQyxuiB24x03HnIXnNVT4Y4C8gmRr3JfBLie2XT3/7gDy6KriGXpR/KE4W509+ctfpb4TWihMZBgRRmLzy7t+e2rErvI+0zbfG8bF+jaK23rooreiwMJJSmMIl1kKFcJrIX0bh5uJxQtfT9hs9WYqWLyz7wjz23NtydJxc1x1b25HaGULIr1+PfUMRG4RzKNNRttvODoxHbemt+/gyI6FNItYLZhOsBg1axJDR6zauYZ1RGk5D2kHjoldidQopScxlB6JvV7wFz0Cz8cW/dsTCi8IHb8bBAx1cOFVGMH6BG/wxPFLonpG49HK1X0Kj5oziMGSTpUYkUHWIooP9Yu6D1tOwklWppEAkwkafQoDrGukXSNACVetu6nN0weDs/hlZFHc4hJkc6+dqcYDx2Y5F7Eu7Ni1gYTFkCTsnfLMC6yAKvGa/MdryBG+7KK+iy5FIID1+hcPdVBn/qNqYWkjHm6Q8CSbmJvm6TbN56NA7GHd0KnjdbK1vvsIn7PHUYKYj1uJTaAw7jEW86UgM6dyG9YcUXw== ec2-user@ip-172-31-32-89'],
                  keys: ['~/.ssh/K74HPd9v_pem.pem']

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
