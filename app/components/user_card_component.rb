# frozen_string_literal: true

class UserCardComponent < ViewComponent::Base
  renders_one :button, ButtonComponent

  # with_collection_parameter :user_card

  def initialize(user_card:)
    @user = user_card
    puts @user.id
  end
end
