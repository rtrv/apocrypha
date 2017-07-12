module Base
  class Creator < Base::ActiveRecordAction
    def create
      perform do
        yield
      end
    end
  end
end
