require 'wanew/client_validate/active_model'
require 'wanew/client_validate/active_record/middleware'

%w{uniqueness}.each do |validator|
  require "wanew/client_validate/active_record/#{validator}"
  validator.capitalize!
  eval "ActiveRecord::Validations::#{validator}Validator.send(:include, WaNew::ClientValidate::ActiveRecord::#{validator})"
end

ActiveRecord::Base.send(:include, WaNew::ClientValidate::ActiveModel::Validations)

