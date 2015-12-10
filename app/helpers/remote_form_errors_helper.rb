module RemoteFormErrorsHelper
	def errors_for(object, method)
		if object.errors[method].present?
			content_tag :small, class: "ls-help-message" do
				object.errors[method].first.html_safe
			end
    end
	end
end