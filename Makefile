install: bundle_install pod_install
install_ruby:
	bash bin/install_ruby.sh
install_bundler: install_ruby
	gem install bundler
bundle_install: install_bundler
	bundle config set --local path 'vendor/bundle'
	bundle install --jobs 4 --retry 3
pod_install:
	bundle exec pod install
