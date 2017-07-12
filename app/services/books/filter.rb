module Books
  class Filter < Base::Filter
    def filter
      scope = Book.include_counts
      scope = scope.include_user_reservations(@user) if @user.present?

      self.result = @query.present? ? scope.search(@query) : scope.all
    end
  end
end
