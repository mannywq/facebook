# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  include Turbo::FramesHelper

  delegate :primary_btn_classes, to: :helpers
  delegate :secondary_btn_classes, to: :helpers

  def initialize(user:, frame:, path:, type:, **options)
    @user = user
    @type = type
    @options = options
    @frame = frame
    @path = path
  end

  def call
    if @type == 'primary'

      @classes = primary_btn_classes

      @options[:class] = @classes

    elsif @type == 'secondary'

      @classes = secondary_btn_classes
      @options[:class] = @classes

    end

    button_to content,
              @path, **@options
  end
end
