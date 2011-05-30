module WaNew::ClientValidate::ActionView::Helpers
	module FormHelper
		def form_for(record_or_name_or_array, *args, &proc)
      raise ArgumentError, "Missing block" unless block_given?

      options = args.extract_options!

      case record_or_name_or_array
      when String, Symbol
        ActiveSupport::Deprecation.warn("Using form_for(:name, @resource) is deprecated. Please use form_for(@resource, :as => :name) instead.", caller) unless args.empty?
        object_name = record_or_name_or_array
      when Array
        object = record_or_name_or_array.last
        object_name = options[:as] || ActiveModel::Naming.singular(object)
        apply_form_for_options!(record_or_name_or_array, options)
        args.unshift object
      else
        object = record_or_name_or_array
        object_name = options[:as] || ActiveModel::Naming.singular(object)
        apply_form_for_options!([object], options)
        args.unshift object
      end

      (options[:html] ||= {})[:remote] = true if options.delete(:remote)

 			@validators = {}
      # Order matters here. Rails mutates the options object
      script = client_form_settings(object, options)
      form   = super(record_or_name_or_array, *(args << options), &proc)
      # Because of the load order requirement above this sub is necessary
      # Would be nice to not do this
      "#{form}#{script ? script.sub('"validator_hash"', @validators.to_json) : nil}#{script_bind(dom_id(object))}".html_safe
		end
		

    def apply_form_for_options!(object_or_array, options)
      super
      options[:html][:validate] = true if options[:validate]
    end

    def fields_for(record_or_name_or_array, *args, &block)
      output = super
      @validators.merge!(args.last[:validators]) if @validators
      output
    end

    private

    def client_form_settings(object, options)
      if options[:validate]
        builder = options[:builder] || ActionView::Base.default_form_builder
        if options[:html] && options[:html][:id]
          var_name = options[:html][:id]
        else
          var_name = if object.respond_to?(:persisted?) && object.persisted?
            options[:as] ? "#{options[:as]}_edit" : dom_id(object, :edit)
          else
            options[:as] ? "#{options[:as]}_new" : dom_id(object)
          end
        end

        content_tag(:script, :type=>'text/javascript') do
          "var #{var_name} = #{builder.client_form_settings(options, self).merge(:validators => 'validator_hash').to_json};".html_safe
        end

      end
    end
    
    def script_bind(id)
  		content_tag(:script, :type=>'text/javascript') do
  			"$('##{id}').validate();"
			end
  	end

	end
end
