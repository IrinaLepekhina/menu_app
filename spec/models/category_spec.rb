require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:category).with_message("must exist") }
    it { is_expected.to belong_to(:category) }
  end

  # describe 'uniqueness' do
  #   let!(:meal) { create(:by_weight_meal) }

  #   it { is_expected.to validate_uniqueness_of(:title).case_insensitive }
  # end

  # it 'converts markdown to html' do
  #   meal = create(:by_weight_meal, description: 'Awesome **food** U *have to* try')
  #   expect(meal.description_html).to include('<strong>food</strong>')
  #   expect(meal.description_html).to include('<em>have to</em>')
  # end

  # it 'has silly title' do
  #   meal = create(:by_weight_meal)
  #   expect(meal.silly_title).to eq("#{meal.title} from #{category.title}")
  # end

  # it 'only fetches meals which title starts from provided letter' do
  #   meal1 = create(:per_unit_meal, title: "bread #{Random.rand(1000)}", category: category)
  #   meal2 = create(:per_unit_meal, title: "chease #{Random.rand(1000)}", category: category)
  #   expect(described_class.by_letter("b")).to eq([meal1])
  # end

  # it 'sorts achievements by category title' do
  #   eat = create(:category, title: 'eat')
  #   drink = create(:category, title: 'drink')
  #   meal1 = create(:per_unit_meal, title: 'lapsha', category: eat)
  #   meal2 = create(:per_unit_meal, title: 'lemon tea', category: drink)
  #   expect(described_class.by_letter("l")).to eq([meal2, meal1])
  # end
end
