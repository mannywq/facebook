# frozen_string_literal: true

class UserCardComponent < ViewComponent::Base
  renders_one :button, ButtonComponent

  # with_collection_parameter :user_card

  def initialize(card)
    @user = card
    puts @user.id
  end
end
