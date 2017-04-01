class PagesController < ApplicationController
	before_action :require_user, only: [:content, :about, :message]


	def home
	end
	def about
		intercom = Intercom::Client.new(token: "dG9rOjY5NzZkNDJkXzdhNzZfNDdmNl85OWQ5X2IzZTk1ZjJiNmM0MjoxOjA=")
  		intercom.events.create(event_name: "Click About", created_at: Time.now.to_i, user_id: current_user.id)

	end
	def thanks
	end
	def content

		intercom = Intercom::Client.new(token: "dG9rOjY5NzZkNDJkXzdhNzZfNDdmNl85OWQ5X2IzZTk1ZjJiNmM0MjoxOjA=")
  		count = intercom.counts.for_type(type: 'user', count: 'segment')
  		@new_user_count = count.user["segment"][3]["New"]
			intercom_custom_data.user[:rails_controller_attr] = "Test Rails Controller"

	end
	def message
		intercom = Intercom::Client.new(token: "dG9rOjY5NzZkNDJkXzdhNzZfNDdmNl85OWQ5X2IzZTk1ZjJiNmM0MjoxOjA=")
		@usermessage = Message.new

	end
end
