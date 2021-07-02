require 'rails_helper'

RSpec.describe '/articles routes', type: :routing do
  it 'routes to articles#index' do
    expect(get('/api/v1/articles')).to route_to('api/v1/articles#index')
    # expect(get('/api/v1/articles?page[number]=3')).to route_to('api/v1/articles#index', page: { page: { number: 3 } })
  end
  it 'routes to articles#show' do
    first_article = create(:article)
    second_article = create(:article)

    expect(get("/api/v1/articles/#{first_article.id}"))
              .to route_to('api/v1/articles#show', id: first_article.id.to_s)

    expect(get("/api/v1/articles/#{second_article.id}"))
              .to route_to('api/v1/articles#show', id: second_article.id.to_s)
  end
end
