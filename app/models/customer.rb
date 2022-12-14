# frozen_string_literal: true

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true

  has_one_attached :profile_image
  has_many :diary_books, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validate :profile_image_type

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end


  def self.guest
    find_or_create_by!(email: "guest@example.com", name: "ゲスト") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

   private


  def profile_image_type
    if profile_image.present?
      if !profile_image.blob
       errors.add(:profile_image, 'をアップロードしてください')
      elsif !profile_image.blob.content_type.in?(%('image/jpeg image/png'))
       errors.add(:profile_image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
      end
    end
  end
end
