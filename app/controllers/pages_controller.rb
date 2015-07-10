class PagesController < ApplicationController
	before_action :require_user, only: [:content]
	def home
	end
	def about
	end
	def thanks
	end
	def content
	end

end
