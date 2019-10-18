# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*methods)
      methods.each do |method|
        raise TypeError, 'Method name is not symbol' unless method.is_a?(Symbol)

        define_method(method) { instance_variable_get("@#{method}").last }

        define_method("#{method}=") do |value|
          new_value = (instance_variable_get('@{method}') || []) << value
          instance_variable_set("@#{method}", new_value)
        end

        define_method("#{method}_history".to_sym) do
          instance_variable_get("@#{method}") || []
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      define_method("#{attr_name}=") do |value|
        unless attr_name.is_a?(attr_class)
          raise TypeError, "Method name is not #{attr_class} class"
        end

        instance_variable_set("@#{attr_name}", value)
      end

      define_method(attr_name) { instace_variable_get("@#{attr_name}") }
    end
  end
end
