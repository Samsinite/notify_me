# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
	s.name        = 'notify_me'
	s.version     = '0.0.1'
	s.authors     = ['Sam Clopton']
	s.email       = ['samsinite@gmail.com']
	s.homepage    = 'https://github.com/samsinite/notify_me'
	s.summary     = 'Notfy Me'
	s.description = 'This friendly library gives you generic notifications in your Rails app.'

	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {spec}/*`.split("\n")
	s.require_paths = ['lib']
end