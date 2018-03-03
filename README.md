# timber

Ruby on Rails application template

### Gems

Timber adds a few common gems used in [Lugo Labs](https://www.lugolabs.com) Ruby on Rails projects.

#### Bootstrap

- `bootstrap`
- `bootstrap_form`
- `jquery-rails`

#### Exception notifications

- `exception_notification`

#### Background jobs

- `sidekiq`

#### Code style
- `rubocop`

#### Deployment

- `capistrano-bundler`
- `capistrano-rails-console`
- `capistrano-rbenv`
- `capistrano-sidekiq`
- `capistrano3-puma`

### Files

Timber generates two files for Rubocop:

- `.rubocop.yml` Adapts Rubocop to Ruby on Rails projects
- `pre-commit` Runs Rubocop when committing a change via git

### Usage

For new apps the template can be applied as an option:

```
rails new blog -m ~/timber/template.rb
rails new blog -m https://raw.githubusercontent.com/lugolabs/timber/master/template.rb
```

For existing applications, you can use the command:

```
bin/rails app:template LOCATION=~/timber/template.rb
bin/rails app:template LOCATION=https://raw.githubusercontent.com/lugolabs/timber/master/template.rb
```
