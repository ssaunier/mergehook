class User < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:github]

  def self.find_for_github_oauth(auth)
    user = where(email: auth.info.email).first
    user ||= where(auth.slice(:provider, :uid)).first
    user ||= User.new
    store_github_info(user, auth)
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

    def self.store_github_info(user, auth)
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      user.email = auth.info.email
      user.github_nickname = auth.info.nickname
      user.name = auth.info.name
      user.gravatar_url = auth.info.image
      user.github_token = auth.credentials.token
      user.save!
    end
end
