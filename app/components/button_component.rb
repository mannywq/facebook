# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(user:, frame:, path:, type:, **options)
    @user = user
    @type = type
    @options = options
    @frame = frame
    @path = path
  end

  def call
    if @type == 'primary'

      @classes = 'p-2 rounded-lg font-bold text-sm text-white bg-blue-700'

      @options[:class] = @classes

    elsif @type == 'secondary'

      @classes = 'p-2 rounded-lg font-bold text-sm text-gray-600 bg-gray-200'

      @options[:class] = @classes

    end

    button_to content,
              @path, **@options
  end
end
