require 'redmine'

require_dependency 'issues_status_hook'

Redmine::Plugin.register :autoassignator do
  name 'Redmine Autoassignator'
  author 'Silvio Quadri'
  description '.'
  version '0.0.1'
  requires_redmine :version_or_higher => '2.0.0'
  settings :default => {
    :status_assigned_to              => {},
  }, :partial => 'settings/autoassignator_settings'
end

