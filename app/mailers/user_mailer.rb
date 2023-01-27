class UserMailer < ApplicationMailer
    def user_created(email, user_id)
			@user_id = user_id
			mail to: email,
				subject: 'Super new user, Hola!'
    end
end
