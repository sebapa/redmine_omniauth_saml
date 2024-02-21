require 'redmine'

require_dependency File.expand_path('../lib/redmine_omniauth_saml', __FILE__)
require_dependency File.expand_path('../lib/redmine_omniauth_saml/hooks', __FILE__)
require_dependency File.expand_path('../lib/redmine_omniauth_saml/user_patch', __FILE__)
require_dependency File.expand_path('../lib/redmine_omniauth_saml/account_helper_patch', __FILE__)
require_dependency File.expand_path('../lib/redmine_omniauth_saml/account_controller_patch', __FILE__)


# Plugin generic informations
Redmine::Plugin.register :redmine_omniauth_saml do
  name 'Redmine Omniauth SAML plugin'
  description 'This plugin adds Omniauth SAML support to Redmine. Based in Omniauth CAS plugin'
  author 'Christian A. Rodriguez'
  author_url 'mailto:car@cespi.unlp.edu.ar'
  url 'https://github.com/chrodriguez/redmine_omniauth_saml'
  version '0.0.1'
  requires_redmine :version_or_higher => '2.3.0'
  settings :default => { 'enabled' => 'true', 'label_login_with_saml' => '', 'replace_redmine_login' => false  },
           :partial => 'settings/omniauth_saml_settings'
end
