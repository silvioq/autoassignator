
class IssueAutoassignatorHook < Redmine::Hook::ViewListener
	def controller_issues_new_before_save(context={})
		update_issues(context[:issue])
	end
	
	def controller_issues_edit_before_save(context={})
		update_issues(context[:issue])
	end
	
	def update_issues(issue)
		plugin = Redmine::Plugin.find(:autoassignator)
		setting = Setting["plugin_#{plugin.id}"] || plugin.settings[:default]
		status_to_user = {}
		setting[:status_assigned_to].each { |s, a|
			unless a.blank?
				f = issue.project.custom_field_values.find { |f| f.custom_field_id == Integer(a) }
				status_to_user[Integer(s)] = Integer(f.value) if f && !f.value.nil? && !f.value.empty?
			end }
		status_to_user
		issue.assigned_to_id = status_to_user[issue.status_id] if status_to_user[issue.status_id]
	end
end
