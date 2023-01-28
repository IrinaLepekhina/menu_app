class Api::MealsController < ApiController
  def index
    meals = Meal.all
    render json: meals
  end
end
