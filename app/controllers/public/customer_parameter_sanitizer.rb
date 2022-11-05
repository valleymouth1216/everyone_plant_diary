# frozen_string_literal: true

class Public::CustomerParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:email, :password, :name, :is_deleted])
  end
end
