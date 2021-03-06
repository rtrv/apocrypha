module Base
  class Service
    attr_accessor :result, :status

    def initialize(options)
      unless options.instance_of? Hash
        raise '`options` should be an instance of `Hash` class'
      end

      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
