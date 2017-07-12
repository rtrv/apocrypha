module Base
  class Destroyer < Base::ActiveRecordAction
    def destroy
      perform do
        yield
      end
    end
  end
end
