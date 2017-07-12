require 'active_support/concern'

module ActiveRecordIndex
  extend ActiveSupport::Concern

  include SecurityExtension

  # Set result of filter, correcponding to controller
  # For exapmle: in BooksController this is gonna set
  # @books = Books::Filter.new(index_filter_params).filter
  def index
    name = "@#{controller_name}"

    filter_instance =
      "#{controller_name.camelize}::Filter".constantize.new(index_filter_params)
    filter_instance.filter

    instance_variable_set(name, filter_instance.result)
  end

  private

  def index_filter_params
    should_be_implemented 'index_filter_params'
  end
end
