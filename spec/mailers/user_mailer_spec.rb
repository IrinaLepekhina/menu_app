require "rails_helper"

RSpec.describe UserMailer do
  include Rails.application.routes.url_helpers

  let(:user_id) { 1 }
  let(:email) { described_class.user_created('new_user@email.com', user_id).deliver_now }

  it 'sends user created email to new_user' do
    expect(email.to).to include('new_user@email.com')
  end

  it 'has correct subject' do
    expect(email.subject).to eq('Super new user, Hola!')
  end

  it 'has user page link in body message' do
    expect(email.body.to_s).to include(user_url(user_id))
  end
end
