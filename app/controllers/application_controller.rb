class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Set result of filter, correcponding to controller
  # For exapmle: in BooksController this is gonna set
  # @books = Books::Filter.new(index_filter_params).filter
  def index
    name = "@#{controller_name}"
    filtered_scope =
      "#{controller_name.camelize}::Filter"
      .constantize
      .new(index_filter_params)
      .filter
    instance_variable_set(name, filtered_scope)
  end

  protected

  def index_filter_params
    raise "`index_filter_params` is not implemented for #{self.class.name}"
  end
end
