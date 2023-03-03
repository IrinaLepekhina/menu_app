module Api::V2
  class MealsController < ApiController
    # http_basic_authenticate_with name: 'user25@email', password: 'qwerty'
    skip_before_action :authenticate_user!, only: [:index]

    def index
      meals = Meal
        .order(created_at: :asc, category_title: :desc)
        .joins(:category)
        .select("meals.*, categories.title as category_title")
        .page(params[:page]).per(10)
        
      render json: meals
    end
  end
end