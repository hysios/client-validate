version_file = File.expand_path("../lib/wanew/client_validate/version",__FILE__)
require version_file

Gem::Specification.new do |gem|
	gem.name 							= "wanew-client-validate"
	gem.version 					= WaNew::ClientValidate::VERSION
	gem.platform 					= Gem::Platform::RUBY
	gem.authors						= ["wanliu corporation","hysios"]
	gem.email 						= ["hysios@gmail.com"]
	gem.homepage 					= "http://github.com/hysios/client_validate"
	gem.summary 					= "WaNew Client Side Validations(like ClientSideValidations)"
	gem.description				= "Client Validate mainly appiled for WaNew Engine in the browser client side validate utils"
	gem.rubyforge_project = gem.name
	
	gem.required_rubygems_version = ">= 1.3.6"
	
	gem.files 						= Dir["{lib}/**/*.rb", "{lib}/**/*.rake", "{lib}/**/*.yml","MIT-LICENSE","init.rb","README"]
	
	gem.require_path = "lib"
	
end