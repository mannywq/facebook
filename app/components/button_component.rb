# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(user:, options:)
    @user = user
    @options = options
  end
end
