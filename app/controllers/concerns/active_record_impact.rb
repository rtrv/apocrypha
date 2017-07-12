require 'active_support/concern'

# Common structure for methods :create, :update and :destroy, which affects
# ActiveRecord objects. They use methods like :create_params to pass into the
# appropriate service
module ActiveRecordImpact
  extend ActiveSupport::Concern
  include SecurityExtension

  ACTIVE_RECORD_IMPACT_ACTIONS = [
    :create, :update, :destroy
  ].freeze

  included do
    # Allow unauthenticated impact at your own risk in specific controller!
    before_action :authenticate_user!, only: ACTIVE_RECORD_IMPACT_ACTIONS
  end

  ACTIVE_RECORD_IMPACT_ACTIONS.each do |method_name|
    define_method method_name do
      service =
        "#{controller_name.camelize}::#{method_name.to_s.camelize}".constantize

      service_instance = service.new(
        send("#{method_name}_params")
      )
      service_instance.perform

      if service_instance.status == :success
        redirect_to :back
      elsif service_instance.status == :error
        # TODO: show error page
        redirect_to :back
      end
    end
  end

  private

  # Make _params methods required
  ACTIVE_RECORD_IMPACT_ACTIONS.each do |method_name|
    params_method = "#{method_name}_params"

    define_method params_method do
      should_be_implemented params_method
    end
  end

  # :destroy usually needs just an ID
  def destroy_params
    { id: params[:id] }
  end
end
