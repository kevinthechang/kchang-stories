class SessionsController < ApplicationController

	def new
	end
	def create
  		@user = User.find_by_email(params[:session][:email])
  		if @user && @user.authenticate(params[:session][:password])
    		session[:user_id] = @user.id
    		intercom = Intercom::Client.new(token: "dG9rOjY5NzZkNDJkXzdhNzZfNDdmNl85OWQ5X2IzZTk1ZjJiNmM0MjoxOjA=")
  			intercom.events.create(event_name: "Logged In", created_at: Time.now.to_i, user_id: @user.id)
    		redirect_to '/content'
        # intercomuser = intercom.users.find(:email => @user.email)
        # intercom.messages.create({
        #   :message_type => 'inapp',
        #   :body => "What's up #{intercomuser.last_seen_ip} :) ",
        #   :from => {
        #     :type => 'admin',
        #     :id   => "125999"
        #   },
        #   :to => {
        #     :type => "user",
        #     :email   => @user.email
        #   }
        # })

  		else
    		redirect_to '/login'
  		end
	end
  	def destroy
    	session[:user_id] = nil
    	redirect_to '/'
  	end
end
