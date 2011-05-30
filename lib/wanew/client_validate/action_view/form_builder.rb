module WaNew::ClientValidate::ActionView::Helpers
	module FormBuilder
		
		def self.included(base)
	    (base.field_helpers - %w(apply_form_for_options! label check_box radio_button fields_for hidden_field)).each do |selector|
	      base.class_eval <<-RUBY_EVAL
	        def #{selector}_with_client_validations(method, options = {})
	          apply_client_validators(method, options)
	          options.delete(:validate)
	          #{selector}_without_client_validations(method, options)
	        end
	      RUBY_EVAL
	
	      base.class_eval { alias_method_chain selector, :client_validations }
	    end
	
	    base.class_eval do
	      alias_method_chain :initialize,                :client_validations
	      alias_method_chain :fields_for,                :client_validations
	      alias_method_chain :check_box,                 :client_validations
	      alias_method_chain :radio_button,              :client_validations
	      alias_method_chain :select,                    :client_validations
	      alias_method_chain :collection_select,         :client_validations
	      alias_method_chain :grouped_collection_select, :client_validations
	      alias_method_chain :time_zone_select,          :client_validations
	
	      def self.client_form_settings(options, form_helper)
	        {
	          #:type => self.to_s,
	          #:input_tag => form_helper.class.field_error_proc.call(%{<span id="input_tag" />}, Struct.new(:error_message, :tag_id).new([], "")),
	          #:label_tag => form_helper.class.field_error_proc.call(%{<label id="label_tag" />}, Struct.new(:error_message, :tag_id).new([], ""))
	        }
	      end
	    end
	  end
	
	  def initialize_with_client_validations(object_name, object, template, options, proc)
	    initialize_without_client_validations(object_name, object, template, options, proc)
	    @options[:validators] = {}
	  end
	
	  def fields_for_with_client_validations(record_or_name_or_array, *args, &block)
	    options = args.extract_options!
	    options[:validate] ||= @options[:validate] if @options[:validate] && !options.key?(:validate)
	    fields_for_without_client_validations(record_or_name_or_array, *(args << options), &block)
	  end
	
	  def check_box_with_client_validations(method, options = {}, checked_value = "1", unchecked_value = "0")
	    apply_client_validators(method, options)
	    check_box_without_client_validations(method, options, checked_value, unchecked_value)
	  end
	
	  def radio_button_with_client_validations(method, tag_value, options = {})
	    apply_client_validators(method, options)
	    radio_button_without_client_validations(method, tag_value, options)
	  end
	
	  def select_with_client_validations(method, choices, options = {}, html_options = {})
	    apply_client_validators(method, html_options)
	    select_without_client_validations(method, choices, options, html_options)
	  end
	
	  def collection_select_with_client_validations(method, collection, value_method, text_method, options = {}, html_options = {})
	    apply_client_validators(method, html_options)
	    collection_select_without_client_validations(method, collection, value_method, text_method, options, html_options)
	  end
	
	  def grouped_collection_select_with_client_validations(method, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
	    apply_client_validators(method, html_options)
	    grouped_collection_select_without_client_validations(method, collection, group_method, group_label_method, option_key_method, option_value_method, options, html_options)
	  end
	
	  def time_zone_select_with_client_validations(method, priority_zones = nil, options = {}, html_options = {})
	    apply_client_validators(method, html_options)
	    time_zone_select_without_client_validations(method, priority_zones = nil, options, html_options)
	  end
	
	private
	
	  def apply_client_validators(method, options = {})
	    if @options[:validate] && options[:validate] != false && validators = filter_validators(@object.client_validation_hash[method], options[:validate])
	    	
	      options.merge!("validate" => validators.to_json)
	      
	      @options[:validators].merge!("#{@object_name}[#{method}]" => validators)
	    end
	  end
	
	  def filter_validators(validators, filters)
	    if validators
	      filtered_validators = validators.inject({}) do |filtered_validators, validator|
	        unless filters && filters.key?(validator.first) && !filters[validator.first]
	          filtered_validators[validator.first] = validator.last
	        end
	
	        filtered_validators
	      end
	
	      filtered_validators.empty? ? nil : filtered_validators
	    end
	  end					
	end
end