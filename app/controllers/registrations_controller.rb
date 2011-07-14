class RegistrationsController < Devise::RegistrationsController
  include Rack::Recaptcha::Helpers

  def new
    super
  end

  def create
    if recaptcha_valid?
      super
    else
      build_resource
      clean_up_passwords(resource)
      flash[:alert] = t :recaptcha_error
      render_with_scope :new
    end
  end
end
