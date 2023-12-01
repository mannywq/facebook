# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(user:, classes:, **options)
    @user = user
    @classes = classes
    @options = options
    @options[:class] = @classes
  end
end
