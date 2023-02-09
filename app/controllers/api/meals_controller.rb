class Api::MealsController < ApiController

  # http_basic_authenticate_with name: 'user25@email', password: 'qwerty'
  def index
    meals = Meal.all
    render json: meals
  end
end
