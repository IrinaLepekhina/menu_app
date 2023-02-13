require 'rails_helper'

RSpec.describe "Meals API" do
  it 'sends meals' do
    category = create(:category)
    by_weight_meal = create(:by_weight_meal, title: 'la ensalsda Mexicana')
    per_unit_meal = create(:per_unit_meal)

    get '/api/meals' # , nil, { "Content-Type": "application/vnd.api+json" }

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)

    expect(json['data'].count).to eq(2)
    expect(json['data'][0]["type"]).to eq('meals')
    expect(json['data'][0]["attributes"]["title"]).to eq('la ensalsda Mexicana')
  end
end
