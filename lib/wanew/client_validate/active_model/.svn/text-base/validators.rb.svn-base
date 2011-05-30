module WaNew::ClientValidate::ActionView::Validations
	module HelperMethods
		
		def self.included(base)
			base.class_eval do 
				
				def validates_presence_of_with_client(*attr_names)
					options = attr_names.extract_options!
					options[:message] ||= ""
					options[:message] += " with client!"
					attr_names << options;

					validates_presence_of_without_client(*attr_names)
				end

				alias_method_chain :validates_presence_of, :client
			end
		end
	end
end