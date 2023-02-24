class MenuSerializer < ApplicationSerializer
  has_many :meals, through: :menu_meals

  attribute :id, if: :current_user
  attribute :title, key: :menu_title
  attributes :date, :url, :next_week

  class MealSerializer < ApplicationSerializer
    attributes :id, :menu_price
    attribute :title, key: :meal_title
    attribute :description do
      object.description.downcase
    end
  
    def menu_price
      object.menu_meals.first.price
    end
  end

  def current_user
    scope
  end

  def attributes(*args)
    data = super
    # data[:just_added] = '1' if current_user.admin?
    data[:just_added] = attributes_list
    data
  end

  def attributes_list
    {
      user_nickname: "current_user.nickname",
    }
  end

  def date
    object.date.to_time.to_i
  end
  
  def url
    # menus_url(object)
    Rails.application.routes.url_helpers.menu_url(object, {host: 'menu.com'}) #{only_path: true})
  end

  def next_week
    "#{ (Time.now.at_beginning_of_week...Time.now.at_end_of_week ).include?(object.date)}"
  end
end

# If you wish to use Rails url helpers for link generation, e.g., link(:resources) { resources_url }, 
# ensure your application sets Rails.application.routes.default_url_options.

# Rails.application.routes.default_url_options = {
#     host: 'example.com'
# }