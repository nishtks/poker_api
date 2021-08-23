Rails.application.routes.draw do
  #  get 'cards/top' => 'cards#top'
  #  post 'cards/submit' => 'cards#submit'
  #  get 'cards/judge' => 'cards#judge'

mount Base::API => '/'  # api/base/api　の上に居る
end