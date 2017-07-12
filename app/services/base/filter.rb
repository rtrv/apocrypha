module Base
  class Filter < Base::Service
    def filter
      raise "Method 'filter' is not implemented for #{self.class.name}"
    end
  end
end
