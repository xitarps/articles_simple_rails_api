require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "#validations" do
    let(:article) { build(:article) }

    it 'tests that factory is correct' do
      expect(article).to be_valid
    end

    it 'has an invalid blank title' do
      article.title= ''

      expect(article).not_to be_valid
      expect(article.errors[:title]).to include 'can\'t be blank'
    end

    it 'has an invalid blank content' do
      article.content= ''

      expect(article).not_to be_valid
      expect(article.errors[:content]).to include 'can\'t be blank'
    end

    it 'has an invalid blank slug' do
      article.slug= ''

      expect(article).not_to be_valid
      expect(article.errors[:slug]).to include 'can\'t be blank'
    end
    it 'has an invalid not unique slug' do
      article.save
      repeated_article = article.dup

      expect(repeated_article).not_to be_valid
      expect(repeated_article.errors[:slug]).to include 'has already been taken'
    end
  end

  describe "#serialize_to_api" do
    it 'returns a valid single json' do
      first_article = create(:article)
      test_article = create(:article)

      body = test_article.serialize_to_api

      # body = JSON.parse(body).deep_symbolize_keys

      expect(body[:data].class).to eq Hash
      expect(body[:data][:id]).to eq test_article.id.to_s
      expect(body[:data][:type]).to eq 'article'
      expect(body[:data][:attributes]).to eq({ title: test_article.title,
                                                 content: test_article.content,
                                                 slug: test_article.slug })
    end
  end

  describe ".serialize_to_api" do
    it 'returns a valid arary json' do
      first_article = create(:article)
      second_article = create(:article)

      body = Article.serialize_to_api.deep_symbolize_keys

      expect(body[:data].class).to eq Array
      expect(body[:data].first[:id]).to eq '2'
      expect(body[:data].last[:id]).to eq '1'
      expect(body[:data].first[:type]).to eq 'article'
      expect(body[:data].last[:type]).to eq 'article'

      expect(body[:data].first[:attributes]).to eq(
        {title: second_article.title, content: second_article.content,
         slug: second_article.slug})

      expect(body[:data].last[:attributes]).to eq(
        { title: first_article.title, content: first_article.content,
          slug: first_article.slug})
    end
    it 'returns arary json order ascendant' do
      first_article = create(:article)
      second_article = create(:article)

      body = Article.serialize_to_api(order: :asc).deep_symbolize_keys

      expect(body[:data].class).to eq Array
      expect(body[:data].first[:id]).to eq '1'
      expect(body[:data].last[:id]).to eq '2'
      expect(body[:data].first[:type]).to eq 'article'
      expect(body[:data].last[:type]).to eq 'article'

      expect(body[:data].first[:attributes]).to eq(
        {title: first_article.title, content: first_article.content,
         slug: first_article.slug})

      expect(body[:data].last[:attributes]).to eq(
        { title: second_article.title, content: second_article.content,
          slug: second_article.slug})
    end
  end
end
