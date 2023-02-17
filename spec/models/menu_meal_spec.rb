require 'rails_helper'

RSpec.describe MenuMeal do
  describe 'validations' do
    describe 'uniqueness' do
      let(:menu) { create(:menu) }
      let(:meal) { create(:meal) }

      it { is_expected.to validate_uniqueness_of(:meal_id).scoped_to(:menu_id).with_message("this meal has been already added") }
    end
  end
end
