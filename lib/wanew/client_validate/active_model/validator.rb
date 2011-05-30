module WaNew::ClientValidate::ActiveModel
  module Validator

    def client_hash(model, attribute)
      extra_options = options.except(*::ActiveModel::Errors::CALLBACKS_OPTIONS - [:on, :allow_blank])
      { :message => model.errors.generate_message(attribute, message_type, extra_options) }.merge(extra_options)
    end

    private

    def message_type
      kind
    end
  end
  	
	module Validations
    def client_validation_hash
      _validators.except(nil, :block).inject({}) do |attr_hash, attr|

        validator_hash = attr[1].inject({}) do |kind_hash, validator|
          client_hash = validator.client_hash(self, attr[0])
          # Yeah yeah, #new_record? is not part of ActiveModel :p
          if (can_use_for_client_validation?(client_hash, validator))
            kind_hash.merge!(validator.kind => client_hash.except(:on))
          else
            kind_hash.merge!({})
          end
        end

        attr_hash.merge!(attr[0] => validator_hash)
      end.delete_if { |key, value| value.blank? }
    end

    private

    def can_use_for_client_validation?(client_hash, validator)
      ((self.respond_to?(:new_record?) && client_hash[:on] == (self.new_record? ? :create : :update)) || client_hash[:on].nil?) && !validator.options.key?(:if) && !validator.options.key?(:unless) && validator.kind != :block
    end		
	end
end


ActiveModel::Validator.send(:include, WaNew::ClientValidate::ActiveModel::Validator)
ActiveModel::Validations.send(:include, WaNew::ClientValidate::ActiveModel::Validations)
