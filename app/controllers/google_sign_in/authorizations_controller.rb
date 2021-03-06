require 'securerandom'

class GoogleSignIn::AuthorizationsController < GoogleSignIn::BaseController
  def create
    redirect_to login_url(scope: 'openid profile email', state: state),
      allow_other_host: true, flash: { proceed_to: params.require(:proceed_to), state: state }
  end

  private
    def login_url(**params)
      client.auth_code.authorize_url(prompt: 'login', **params)
    end

    def state
      @state ||= SecureRandom.base64(24)
    end
end
