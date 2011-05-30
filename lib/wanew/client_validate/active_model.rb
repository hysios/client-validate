module WaNew
	module ClientValidate
		module ActiveModel
		end
	end
end

require 'active_model/validator'

require 'wanew/client_validate/active_model/validators'
require 'wanew/client_validate/active_model/validator'

ActiveModel::Validations::HelperMethods.send(:include, 
	WaNew::ClientValidate::ActionView::Validations::HelperMethods) if defined?(:ActiveModel)