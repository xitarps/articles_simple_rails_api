require 'rails_helper'

RSpec.describe Api::V1::ArticlesController do
  describe "#index" do
    it 'returns a success response' do
      get '/api/v1/articles'

      expect(response).to have_http_status(:ok) 
    end

    it 'returns a proper JSON' do
      article = create(:article)
      get '/api/v1/articles'

      body = JSON.parse(response.body, symbolyze_keys: true)

      expect(body).to eq ({
        data: [
          {
            id: article.id,
            type: 'articles',
            attributes:
            {
              title: article.title,
              content: article.content,
              slug: article.slug
            }
          }
        ]
      }.as_json)
    end
  end
end