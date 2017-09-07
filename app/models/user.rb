class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, dependent: :destroy
  has_one :profile, dependent: :destroy

  def has_profile?
    profile.present? && profile.persisted?
  end

  def full_name
    profile.full_name
  end
end
