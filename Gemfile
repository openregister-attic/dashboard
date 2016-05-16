source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '>= 5.0.0.beta4', '< 5.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
# gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'slim'
gem 'govuk_frontend_toolkit'
gem 'govuk_template'
gem 'govuk_elements_rails'
gem 'govuk_elements_form_builder', git: 'https://github.com/ministryofjustice/govuk_elements_form_builder.git'

gem 'openregister-ruby', git: 'https://github.com/robmckinnon/openregister-ruby.git'

gem 'mongoid', git: 'https://github.com/mongodb/mongoid.git'
gem 'mongoid_slug', '>= 4.0.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'rspec', git: 'https://github.com/rspec/rspec.git', branch: 'master'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails.git', branch: 'master'
  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core.git', branch: 'master'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support.git', branch: 'master'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations.git', branch: 'master'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks.git', branch: 'master'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  require 'rbconfig'
  if RbConfig::CONFIG['target_os'] =~ /darwin(1[0-3])/i
    gem 'rb-fsevent', '<= 0.9.4'
  end
  gem 'listen', '>= 3.1.4'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'

  gem 'guard-rspec', require: false, git: 'https://github.com/robmckinnon/guard-rspec', branch: 'master'
end

group :test do
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
