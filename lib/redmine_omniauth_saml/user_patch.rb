require_dependency 'user'

module RedmineOmniauthSaml::UserPatch
  def self.prepended(base)
    class << base
      self.prepend(RedmineOmniauthSaml::UserPatchMethods)
    end
  end

  module RedmineOmniauthSaml::UserPatchMethods
    def find_or_create_from_omniauth(omniauth)
      user_attributes = RedmineOmniauthSaml.user_attributes_from_saml omniauth
      user = self.find_by_login(user_attributes[:login])
      unless user
        user = EmailAddress.find_by(address: user_attributes[:mail]).try(:user)
        if user.nil? && RedmineOmniauthSaml.onthefly_creation? 
          user = new user_attributes
          user.created_by_omniauth_saml = true
          user.login    = user_attributes[:login]
          user.language = Setting.default_language
          user.activate
          user.save!
          user.reload
        end
      end
      RedmineOmniauthSaml.on_login_callback.call(omniauth, user) if RedmineOmniauthSaml.on_login_callback
      user
    end
  end


  def change_password_allowed?
    super && !created_by_omniauth_saml?
  end

end

User.prepend(RedmineOmniauthSaml::UserPatch)
