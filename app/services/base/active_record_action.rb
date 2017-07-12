module Base
  class ActiveRecordAction < Base::Service
    def perform
      ActiveRecord::Base.transaction do
        begin
          self.status = :success

          yield
        rescue StandardError => e
          self.result = e.to_s
          self.status = :error

          raise ActiveRecord::Rollback, e
        end
      end
    end
  end
end
