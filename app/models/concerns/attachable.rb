module Attachable
  extend ActiveSupport::Concern
  included do
    has_one_attached :avatar do |at|
      at.variant :thumb, resize_to_limit: [300, 300], saver: { quality: 80 }
      at.variant :large, resize_to_limit: [1500, 1500], saver: { quality: 80 }
    end
    has_one_attached :header_photo do |at|
      at.variant :thumb, resize_to_limit: [300, 300], saver: { quality: 80 }
      at.variant :large, resize_to_limit: [1500, 1500], saver: { quality: 80 }
    end
  end

  def valid_image
    acceptable = ['image/jpeg', 'image/png']
    return unless avatar.attached?

    unless acceptable.include?(avatar.content_type)
      errors.add(:avatar,
                 "Content type not accepted: #{avatar.content_type}")
      return
    end
    return unless header_photo.attached?

    return if acceptable.include?(header_photo.content_type)

    errors.add(:header_photo, "Content type not accepted: #{header_photo.content_type}")
  end

  def grab_avatar_url
    url = URI.parse('https://randomuser.me/api/?inc=picture')
    response = Net::HTTP.get_response(url)
    data = JSON.parse(response.body)

    data['results'][0]['picture']['large']
  end

  def grab_avatar_image
    img = URI.parse(grab_avatar_url).open
    avatar.attach(io: img, filename: "User_#{id}")
  end

  def grab_header_image
    client = Pexels::Client.new(Rails.application.credentials.dig(:pexels, :api_key))
    res = client.photos.search('ocean', page: 1, per_page: 50)
    # data = JSON.parse(res)
    num = rand(0..50)
    url = res.photos[num].src['medium']
    puts url

    img = URI.parse(url).open
    header_photo.attach(io: img, filename: "User_#{id}_header_photo")
  rescue StandardError => e
    Rails.logger.error "Error fetching image: #{e.message}"
  end
end
