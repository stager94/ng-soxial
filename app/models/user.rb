class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	before_save :ensure_authentication_token
	validates_presence_of :first_name, :last_name, :nickname
	validates_uniqueness_of :nickname

	has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#", small: "40x40#" }
	has_attached_file :cover, styles: { original: "700x700>" }

	acts_as_inkwell_user

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	private

	def generate_authentication_token
		loop do
			token = Devise.friendly_token
			break token unless User.where(authentication_token: token).first
		end
	end

end
