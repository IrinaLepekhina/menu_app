module Api::V2
  class MealsController < ApiController
    # http_basic_authenticate_with name: 'user25@email', password: 'qwerty'
    skip_before_action :authenticate_user!, only: [:index]

    def index
      meals = Meal.all
        
      render json: meals
    end
  
  end
end