require 'rails_helper'

RSpec.describe "Meals API", type: :request do
  it 'sends meals' do
    # by_weight_meal = create(:by_weight_meal, title: 'la ensalsda Mexicana')
    # per_unit_meal = create(:per_unit_meal)

    get '/api/meals' #, nil, { "Content-Type": "application/vnd.api+json" }

    # expect(response.status).to eq(200)
    # json = JSON.parse(response.body)

    # expect(json['data'].count).to eq(2)
    # expect(json['data'][0]["type"]).to eq('meals')
    # expect(json['data'][0]["attributes"]["title"]).to eq('la ensalsda Mexicana')
  end
end
