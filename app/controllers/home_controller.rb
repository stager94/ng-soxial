class HomeController < ApplicationController
	def index
		render layout: "application", nothing: true
	end
end
