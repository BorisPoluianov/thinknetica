# frozen_string_literal: true

# Module for calculating number of instances for classes
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  # initialize instances variable in class
  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end
  end

  # calculating new instance
  module InstanceMethods
    private

    def register_instance
      self.class.instances += 1
    end
  end
end
