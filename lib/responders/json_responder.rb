module Responders::JsonResponder
  protected

  # simply render the resource even on POST instead of redirecting for ajax
  def api_behavior(error)
    if post?
      display resource, status: :created
    # render resource instead of 204 no content
    elsif put?
      display resource, status: :ok
    else
      super
    end
  end

  def json_resource_errors
    # Hack to get around PCDValidationError expecting a hash of properties to array of errors, and not handling "Prospect.first_name" gracefully.
    {:errors => resource.errors.full_messages.map { |e| { e.gsub('.', ' ') => [] } }}
  end
end