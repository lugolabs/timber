# Bootstrap
gem 'bootstrap', '~> 4.0.0.beta'
gem 'bootstrap_form', github: 'bootstrap-ruby/rails-bootstrap-forms'
gem 'jquery-rails'

# Exceptions
gem 'exception_notification', github: 'smartinez87/exception_notification'

# Background jobs
gem 'sidekiq'

gem_group :development do
  # Code checks
  gem 'rubocop', require: false

  # Deployment
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano3-puma', require: false
end

# Rubocop file
file '.rubocop.yml', <<-CODE
AllCops:
  Exclude:
    - db/schema.rb
    - db/seeds.rb
    - db/migrate/*
    - bin/*
    - config/**/

Rails:
  Enabled: true

Documentation:
  Enabled: false

Rails/OutputSafety:
  Enabled: false

DotPosition:
  Enabled: false

Layout/EmptyLinesAroundBlockBody:
  Enabled: false

Layout/EmptyLinesAroundModuleBody:
  Enabled: false

Layout/EmptyLinesAroundClassBody:
  Enabled: false

Layout/EmptyLinesAroundMethodBody:
  Enabled: false

Layout/DotPosition:
  Enabled: false

Layout/IndentHash:
  Enabled: false

Style/EmptyMethod:
  Enabled: false

Style/RegexpLiteral:
  Enabled: false

Lint/AmbiguousBlockAssociation:
  Enabled: false

Metrics/BlockLength:
  Exclude:
    - config/routes.rb
    - config/**/*.rb
    - test/**/*.rb

Metrics/LineLength:
  Max: 125
  Exclude:
    - config/**/*.rb

Metrics/MethodLength:
  Max: 12

Style/ClassAndModuleChildren:
  Exclude:
    - test/**/*.rb
CODE


# Call Rubocop before comitting
file '.git/hooks/pre-commit', <<-CODE
file
#!/bin/sh
#
# Check for ruby style errors

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
NC='\033[0m'

against=HEAD

# Check if rubocop is installed for the current project
bin/bundle exec rubocop -v >/dev/null 2>&1 || { echo >&2 "${red}[Ruby Style][Fatal]: Add rubocop to your Gemfile"; exit 1; }

# Get only the staged files
FILES="$(git diff --cached --name-only --diff-filter=AMC | grep "\.rb$" | tr '\n' ' ')"

echo "${green}[Ruby Style][Info]: Checking Ruby Style${NC}"

if [ -n "$FILES" ]
then
  echo "${green}[Ruby Style][Info]: ${FILES}${NC}"

  if [ ! -f '.rubocop.yml' ]; then
    echo "${yellow}[Ruby Style][Warning]: No .rubocop.yml config file.${NC}"
  fi

  # Run rubocop on the staged files
  bin/bundle exec rubocop --force-exclusion ${FILES}

  if [ $? -ne 0 ]; then
    echo "${red}[Ruby Style][Error]: Fix the issues and commit again${NC}"
    exit 1
  fi
else
  echo "${green}[Ruby Style][Info]: No files to check${NC}"
fi

exit 0
CODE

# Make it executable
run 'chmod a+x .git/hooks/pre-commit'

# Run Rubocop
after_bundle do
  rails_command 'bundle exec rubocop --auto-correct'
end
