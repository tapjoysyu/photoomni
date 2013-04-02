class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation

  has_one :user_profile, dependent: :destroy
  has_many :topics
  has_many :posts

  alias_method :profile, :user_profile

  delegate :avatar, to: :user_profile, :allow_nil => true

  before_create :build_default_user_profile

  acts_as_authentic

  def display_name
    if profile.present? && profile.full_name.present?
      profile.full_name
    else
      email
    end
  end

  private
  def build_default_user_profile
    build_user_profile
    true
  end

end
