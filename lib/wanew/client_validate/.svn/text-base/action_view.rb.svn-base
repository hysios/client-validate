module WaNew
	module ClientValidate
		module ActionView
			module Helpers
				
			end
		end
	end
end


require 'wanew/client_validate/action_view/form_helper'
require 'wanew/client_validate/action_view/form_builder'

ActionView::Base.send(:include, WaNew::ClientValidate::ActionView::Helpers::FormHelper)
ActionView::Helpers::FormBuilder.send(:include, WaNew::ClientValidate::ActionView::Helpers::FormBuilder)
