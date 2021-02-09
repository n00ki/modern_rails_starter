# Reactive Rails Starter :rocket:

***Reactive Rails Starter*** is an opinionated, fully configured template for developing reactive web application using Rails 6. Pre-Configured with Hotwire (Turbo & StimulusJS), TailwindCSS, ViewComponent, Devise, Pundit, Sidekiq, Pagy and many other great tools, you can use this template to kickstart your own reactive web applications.

This template is based almost exclusively on the amazing contributions of [Andy Leverenz](https://github.com/justalever) & [Chris Oliver](https://twitter.com/excid3/). Please consider supporting their work.

## Prerequisites
* **rbenv (recommended)** / RVM / chruby ***(optional)**
* Ruby (>= 2.5)
* Rails (>= 6.0) - `gem install rails` 
* Bundler - `gem install bundler`
* Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
* Redis - `brew install redis` or [Install Redis](https://redis.io)
* Hivemind / Foreman ***(optional)** - `gem install hivemind` 

## :hammer: Toolbox (Included, pre-configured gems & tools)
 General:

- [TailwindCSS](https://tailwindcss.com)
- [Hotwire](https://hotwire.dev)
- [ViewComponent](https://viewcomponent.org)
- [devise](https://github.com/plataformatec/devise)
- [devise_masquerade](https://github.com/oivoodoo/devise_masquerade)
- [friendly_id](https://github.com/norman/friendly_id)
- [Sidekiq](https://github.com/mperham/sidekiq)
- [Pundit](https://github.com/varvet/pundit)
- [mini_magick](https://github.com/minimagick/minimagick)
- [name_of_person](https://github.com/basecamp/name_of_person)
- [Pagy](https://github.com/ddnexus/pagy)
- [whenever](https://github.com/javan/whenever)
- [ActiveStorage](https://edgeguides.rubyonrails.org/active_storage_overview.html)

Development:

- [pry-rails](https://github.com/rweng/pry-rails)
- [faker](https://github.com/faker-ruby/faker)
- [annotate](https://github.com/ctran/annotate_models)

## Getting Started

The easiest way to get started is to clone the repository, create a new rails app and pass the template file through:

```bash
# Get the latest snapshot from GitHub
git clone https://github.com/sahat/hackathon-starter.git reactive_rails_starter

# Navigate to your projects directory and create a new app
rails new my_app -d <postgresql, mysql, sqlite3> -m /path/to/reactive_rails_starter/template.rb

# Change directory
cd my_app

# Run your Rails application

# In Development:
hivemind Procfile.dev

# In Production:
hivemind Procfile
```

### Once created, what do i get?

- `TailwindCSS` Support (using `Webpack`).
- flexible authentication with `Devise` (a new `name` field already migrated in, which maps to the `first_name` and `last_name` fields in the database (thanks to the `name_of_person` gem). 
- Pre-baked, devise-compatible Turbo & StimulusJS (`Hotwire` )support.
- `ViewComponent` Support. This template installs the gem and generates a test component (and preview).
- Simple, efficient background processing with `Sidekiq` and `whenever`.
- Object oriented authorization with `Pundit`.
- `Friendly ID`s initialization out-of-the-box. This template installs the gem and runs the associated generator, check [friendly_id's](https://github.com/norman/friendly_id) documentation for more information about integrating it with your own models.
- Better pagination out-of-the-box with `Pagy`. This template installs the gem, initializes it and creates the default config file. 
- Ready-to-use `ActiveStorage` and `mini_magick`.
- Developer happiness guaranteed with great tools like `pry-rails`, `faker` and `annotate`.
- Enhanced boilerplate views using `TailwindCSS` (thanks to [Andy Leverenz](https://github.com/justalever)).
- `Hivemind/Foreman` Support (environment-based `Profciles`)
- `Git` initialization out-of-the-box.
- `PurgeCSS` configuration.
- Custom defaults for button and form elements (by [Andy Leverenz](https://github.com/justalever)).

### Stop procrastinating, start building! :muscle:
