# frozen_string_literal: true

require 'rails_helper'

describe  SessionsController do
	let(:user) { FactoryBot.create(:user, password: 'password123') }
    
  describe "POST create" do
    context "valid password" do
			it "redirects to root page" do
				post :create, params: { session: {email: user.email, password: user.password} }
				expect(response).to redirect_to(root_path)
			end
			
			it "set user_id in session" do
				post :create, params: { session: {email: user.email, password: user.password} }
				expect(session[:user_id]).to be_truthy
			end
		end

		context "invalid password" do
			it "redirects to login page" do
				post :create, params: { session: {email: user.email, password: 'wrong'}}
				expect(response).to render_template(:new)
				expect(flash[:alert]).to be_truthy
			end
		
			it "not settle user_id in session" do
				post :create, params: { session: {email: user.email, password: 'wrong'}}
				expect(session[:user_id]).to be_falsy
			end
		end

  end

	describe "DELETE destroy" do

		before do
			user&.authenticate('password123')
			request.session[:user_id] = user.id
		end

		it "redirects to login page" do
			delete :destroy, params: { id: user.id }
			expect(response).to redirect_to(root_path)
		end

		it "deletes user_id from session" do
			delete :destroy, params: { id: user.id }
			expect(session[:user_id]).to be_falsy
		end
	end

end