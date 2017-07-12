class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ActiveRecordIndex
  include ActiveRecordImpact
end
