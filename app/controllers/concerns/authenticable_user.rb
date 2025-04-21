# Tests for this module are written inside spec/shared/authenticable_user_spec.rb 

module AuthenticableUser
  private

  def current_user
    @current_user ||= grab_auth_resource_by(User)
  end

  # Use this for another devise model e.g., Customer
  # def current_customer
  #   @current_customer ||= grab_auth_resource_by(Customer)
  # end

  def token
    @token ||= request.headers["Authorization"].to_s.split(" ").last
  end

  def decoded_token
    @decoded_token ||= JWT.decode(token, secret_key, false)
  rescue JWT::DecodeError
    nil
  end

  def payload_data
    return { "bypass_for_timezone" => true } if decoded_token.nil?
    @payload_data ||= decoded_token.reduce({}, :merge)
  end

  def secret_key
    Rails.application.credentials.secret_key_base
  end

  def grab_auth_resource_by(klass)
    return nil if payload_data["bypass_for_timezone"]
    klass.find_by(id: payload_data["sub"])
  end
end