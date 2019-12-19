# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glutton_ratelimit 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "glutton_ratelimit".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Wally Glutton".freeze]
  s.date = "2019-12-19"
  s.description = "A Ruby library for limiting the number of times a method can be invoked within a specified time period.".freeze
  s.email = "stungeye@gmail.com".freeze
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".github/workflows/ruby.yml",
    ".ruby-version",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "examples/limit_instance_methods.rb",
    "examples/simple_manual.rb",
    "glutton_ratelimit.gemspec",
    "lib/glutton_ratelimit.rb",
    "lib/glutton_ratelimit/averaged_throttle.rb",
    "lib/glutton_ratelimit/bursty_ring_buffer.rb",
    "lib/glutton_ratelimit/bursty_token_bucket.rb",
    "test/helper.rb",
    "test/test_glutton_ratelimit_averaged_throttle.rb",
    "test/test_glutton_ratelimit_bursty_ring_buffer.rb",
    "test/test_glutton_ratelimit_bursty_token_bucket.rb",
    "test/testing_module.rb"
  ]
  s.homepage = "http://github.com/stungeye/glutton_ratelimit".freeze
  s.rubygems_version = "2.7.6.2".freeze
  s.summary = "Simple Ruby library for self-imposed rater-limiting.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<test-unit>.freeze, [">= 0"])
    else
      s.add_dependency(%q<jeweler>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, [">= 0"])
  end
end

