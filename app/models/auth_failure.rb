class AuthFailure < Devise::FailureApp
  def respond
    if http_auth?
      http_auth
    elsif warden_options[:recall]
      recall
    else
      json_failure
    end
  end

  def json_failure
    self.status = 200
    self.content_type = 'json'
    self.response_body = { success: false, error: "Login Failed" }.to_json
  end
end