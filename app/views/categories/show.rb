<%= f.simple_fields_for :meals, @category.meals.build do |meals_form| %>
    <div id='fieldsetContainer'>
      <fieldset id="0" class="text-indigo-500">
  
        <%= meals_form.input :title, list: "meals_autocomplete", label: 'Meal title' %>
          <datalist id="meals_autocomplete">
            <% Meal.all.each do |meal| %>
              <option value="<%= meal.title %>">
            <% end %>
          </datalist>
        <%= meals_form.association :category, :prompt => 'Choose an existing Item', label: 'Category' %>
        <%= meals_form.input :price_type, collection: Meal.price_types.map { |k,v| [ k.split('_').join(' '), k ]} %>
        <%= meals_form.input :price_init, label: 'Price' %>
        <br/>
   
      </fieldset>
    </div>
  <% end %>
  
  <button id=”addMeal”>Add more meals</button>