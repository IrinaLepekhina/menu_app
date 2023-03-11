# frozen_string_literal: true

require 'rails_helper'

# require_relative '../support/login_form.rb'
require_relative '../support/authenticate_user_helper.rb'
require

describe AuthenticateUser do
  describe '#authenticated?' do

    it "authenticate, if email and password match" do
      user = create(:user)

      expect(AuthenticateUser.new(email: user.email, password: user.password)).to be_authenticated
      expect{AuthenticateUser.new(email: user.email, password: user.password).authenticated? }.not_to raise_error
    end

    it "raises AuthenticationError, when no match" do
      user = create(:user)
      expect {
        AuthenticateUser.new(email: :email, password: '').authenticated?
      }.to raise_error(ExceptionHandler::AuthenticationError)

      expect {
        AuthenticateUser.new(email: '', password: user.password).authenticated?
      }.to raise_error(ExceptionHandler::AuthenticationError)
    end
  end

  describe '#user' do
    it "matches username" do
      user = create(:user)
      expect(signin(user)).to eq(user) # private method does not work
      expect(AuthenticateUser.new(email: user.email, password: user.password).send(:user)).to eq(user) # private method does not work
    end
  end
end
