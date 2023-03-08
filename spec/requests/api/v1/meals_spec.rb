require 'rails_helper'

RSpec.describe Api::V1::MealsController, type: :request do
  describe "GET index" do
    it 'sends meals' do
      user = create(:user)
      user.authenticated
      
      category = create(:category)
      by_weight_meal = create(:by_weight_meal, title: 'la ensalsda Mexicana')
      per_unit_meal = create(:per_unit_meal)

      get '/api/meals', params: {}, 
        headers: {'Accept': 'application/vnd.menu_app_m.v1+json'}

      # expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.count).to eq(2)
      expect(json[0]["meal_title"]).to eq('la ensalsda Mexicana')
    end
  end
end

# expect(json['data'].count).to eq(2)
# expect(json['data'][0]["type"]).to eq('meals')
# expect(json['data'][0]["attributes"]["title"]).to eq('la ensalsda Mexicana')

