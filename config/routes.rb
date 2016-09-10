Rails.application.routes.draw do

  scope module: :api, defaults: {format: 'json'} do
    scope module: :bird do
      get 'birds' => 'birds#birds_list', as: :birds
      post'birds' =>'birds#add_bird'
      get 'birds/:id' => 'birds#display_bird'
      delete 'birds/:id' => 'birds#remove_bird'
    end
  end

end
