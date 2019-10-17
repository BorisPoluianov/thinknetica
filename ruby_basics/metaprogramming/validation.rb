# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
  attr_reader :valid_params

    def validate(attr_name, *args)
      @valid_params ||= []
      @valid_params << { attr_name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.valid_params.each do |attr|
        attr.each do |name, params|
          value = instance_variable_get("@#{name}".to_sym)
          valid_type, *valid_args = params
          send "validate_#{valid_type}".to_sym, name, value, valid_args
        end
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    private

    def validate_presence(name, value, _args)
      raise "Attribute #{name} has no value!" if value.nil? || ((value.is_a? String) && value.strip.empty?)
    end

    def validate_format(name, value, args)
      raise "Attribute #{name} has wrong format!" if value !~ args.first
    end

    def validate_type(name, value, args)
      raise "Attribute #{name} not is a #{args.first} class!" unless value.is_a? args.first
    end
  end
end
