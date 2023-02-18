require 'rails_helper'

RSpec.describe MenuMeal do
  describe 'validations' do
    describe 'uniqueness' do
      let!(:menu) { create(:menu) }
      let!(:category) { create(:category) }
      let!(:meal) { create(:per_unit_meal) }
      let!(:menu_meal) { create(:menu_meal) }

      it { is_expected.to validate_uniqueness_of(:meal_id).scoped_to(:menu_id).with_message("this meal has been already added") }
    end
  end
end
