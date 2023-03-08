require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :request do
  describe "GET index" do
    it 'sends meals' do
      user = create(:user)
      auth_token = AuthenticateUser.new(user.email, user.password).call
      ## authenticate before requests
      
      category = create(:category)
      by_weight_meal = create(:by_weight_meal, title: 'la ensalsda Mexicana')
      per_unit_meal = create(:per_unit_meal)

      get '/api/meals', params: {}, 
        headers: {
          'Accept': 'application/vnd.menu_app_m.v1+json',
          'Authorization': "#{auth_token}"
        }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
      expect(json[0]["meal_title"]).to eq('la ensalsda Mexicana')
    end
  end
end



