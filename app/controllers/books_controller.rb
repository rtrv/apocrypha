class BooksController < ApplicationController
  private

  def index_filter_params
    { query: params[:query] }
  end
end
