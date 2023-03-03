Rails.application.routes.draw do
  scope :api, defaults: { format: 'json' } do
    resources :messages, only: %i(create destroy) do
      member do
        post :upvote
        post :downvote
      end
    end
  end
end
