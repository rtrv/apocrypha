module Books
  class Filter < BaseFilter
    def filter
      @result = @query.present? ? Book.search(@query) : Book.all
    end
  end
end
