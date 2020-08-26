class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_one_attached :thumbnail
  has_one_attached :banner
  
  has_rich_text :body

  validates :title, length: { minimum: 5 }
  validates :body, length: { minimum: 25 }

  self.per_page = 10  # Para will_paginate

  # Friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged

  after_commit :add_default_images, on: [:create, :update]

  def optimized_image(image, x, y)
    image.variant(resize_to_fill: [x, y]).processed
  end

  private
  def add_default_images
    unless banner.attached?
      self.banner.attach(io: File.open(Rails.root.join("app", "assets", "images", "default", "default_banner.jpg")), filename: 'default_banner.jpg', content_type: "image/jpg")
    end
    unless thumbnail.attached?
      self.thumbnail.attach(io: File.open(Rails.root.join("app", "assets", "images", "default", "default_thumbnail.jpg")), filename: 'default_thumbnail.jpg', content_type: "image/jpg")
    end
  end

end
