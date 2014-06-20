class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:github]

  def self.find_for_github_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.github_nickname = auth.info.nickname
      user.name = auth.info.name
      user.gravatar_url = auth.info.image
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
