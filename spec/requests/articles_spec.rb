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

      expected = json_data.first

      expect(json_data.length).to eq 1
      expect(expected[:id]).to eq article.id
      expect(expected[:type]).to eq 'article'
      expect(expected[:attributes]).to eq( { title: article.title,
                                             content: article.content,
                                             slug: article.slug })
    end
  end
end