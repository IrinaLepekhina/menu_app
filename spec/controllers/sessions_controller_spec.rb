
# # frozen_string_literal: true

# require 'rails_helper'

# describe  SessionsController do

#   describe "DELETE destroy" do
#     let(:user) { FactoryBot.create(:user, email: 'first@email', nickname: 'ready_user_one') }

#     it "redirects to meals#index" do
    
#        delete :destroy, params: { id: user.id }
#        expect(response).to redirect_to(session_path)
#     end

#     it "deletes current_user" do
#       delete :destroy, params: { id: user.id }
#       expect(controller.current_user.exists?(user.id)).to be_falsy
#     end

#   end
# end