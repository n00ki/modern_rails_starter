# Template Name: Modern Rails Starter
# Author: Noam Shemesh
# Instructions: $ rails new myapp -d <postgresql, mysql, sqlite3> -m template.rb

def source_paths
  [__dir__]
end

def add_gems
  gem 'devise_masquerade', '~> 1.3', '>= 1.3.1'
  gem 'devise', '~> 4.7', '>= 4.7.3'
  gem 'friendly_id', '~> 5.4', '>= 5.4.2'
  gem 'hotwire-rails'
  gem 'mini_magick', '~> 4.11', '>= 4.11.0'
  gem 'name_of_person', '~> 1.1', '>= 1.1.1'
  gem 'pagy', '~> 3.10', '>= 3.10'
  gem 'pundit', '~> 2.1'
  gem 'sidekiq', '~> 6.1', '>= 6.1.2'
  gem 'whenever', require: false
  gem 'view_component', require: 'view_component/engine'

  gem_group :development, :test do
    gem 'annotate', '~> 3.1', '>= 3.1.1'
    gem 'faker', '~> 2.15', '>= 2.15.1'
    gem 'pry-rails', '~> 0.3.9'
  end
end

def add_users
  # Install Devise
  generate 'devise:install'

  # Configure Devise
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }",
              env: 'development'

  route "root to: 'home#index'"

  # Create Devise User
  generate :devise, 'User', 'first_name', 'last_name', 'admin:boolean'

  # set admin boolean to false by default
  in_root do
    migration = Dir.glob('db/migrate/*').max_by { |f| File.mtime(f) }
    gsub_file migration, /:admin/, ':admin, default: false'
  end

  # name_of_person gem
  append_to_file('app/models/user.rb', "\nhas_person_name\n", after: 'class User < ApplicationRecord')
end

def copy_templates
  directory 'app', force: true
end

def add_tailwind
  # Until PostCSS 8 ships with Webpacker/Rails we need to run this compatability version
  # See: https://tailwindcss.com/docs/installation#post-css-7-compatibility-build
  run 'yarn add tailwindcss@npm:@tailwindcss/postcss7-compat postcss@^7 autoprefixer@^9'
  run 'mkdir -p app/javascript/stylesheets'

  append_to_file('app/javascript/packs/application.js', 'import "stylesheets/application"')
  inject_into_file('./postcss.config.js',
                   "\n    require('tailwindcss')('./app/javascript/stylesheets/tailwind.config.js'),", after: 'plugins: [')

  run 'mkdir -p app/javascript/stylesheets/components'
end

# Remove Application CSS
def remove_app_css
  remove_file 'app/assets/stylesheets/application.css'
end

def add_hotwire
  rails_command 'hotwire:install'
end

def add_view_component
  generate 'component Example title content --preview'
end

def add_sidekiq
  environment 'config.active_job.queue_adapter = :sidekiq'

  insert_into_file 'config/routes.rb',
                   "require 'sidekiq/web'\n\n",
                   before: 'Rails.application.routes.draw do'

  content = <<-RUBY
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  RUBY
  insert_into_file 'config/routes.rb', "#{content}\n\n", after: "Rails.application.routes.draw do\n"
end

def add_procfiles
  copy_file 'Procfile'
  copy_file 'Procfile.dev'
end

def add_friendly_id
  generate 'friendly_id'
end

def add_whenever
  run 'wheneverize .'
end

def add_pundit
  generate 'pundit:install'
end

def copy_initializers
  directory 'config/initializers', force: true
end

def add_active_storage
  rails_command 'active_storage:install'
end

def add_annotate
  generate 'annotate:install'
end

def stop_spring
  run 'spring stop'
end

# Main setup
source_paths

add_gems

after_bundle do
  stop_spring
  add_users
  remove_app_css
  add_sidekiq
  add_procfiles
  copy_templates
  add_tailwind
  add_hotwire
  add_view_component
  add_friendly_id
  add_whenever
  add_pundit
  copy_initializers
  add_active_storage
  add_annotate

  # Migrate
  rails_command 'db:create'
  rails_command 'db:migrate'

  git :init
  git add: '.'
  git commit: %( -m "Initial commit" )

  say
  say 'you have successfully created a Modern Rails app! 🙏🏼', :blue
  say
  say 'Switch to your app by running:'
  say "$ cd #{app_name}", :yellow
  say
end
