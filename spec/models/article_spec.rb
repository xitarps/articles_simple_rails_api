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
      second_article = create(:article)

      body = second_article.serialize_to_api.as_json
      
      expect(body).to eq(
        {
          data:{
            id: second_article.id,
            type: 'article',
            attributes:
            {
              title: second_article.title,
              content: second_article.content,
              slug: second_article.slug
            }
          }
        }.as_json)
    end
  end

  describe ".serialize_to_api" do
    it 'returns a valid arary json' do
      first_article = create(:article)
      second_article = create(:article)

      expect(Article.serialize_to_api).to eq(
        {
          data: [
            {
              id: second_article.id,
              type: 'article',
              attributes:
              {
                title: second_article.title,
                content: second_article.content,
                slug: second_article.slug
              }
            },
            {
              id: first_article.id,
              type: 'article',
              attributes:
              {
                title: first_article.title,
                content: first_article.content,
                slug: first_article.slug
              }
            }
          ]
        })
    end
    it 'returns arary json order ascendant' do
      first_article = create(:article)
      second_article = create(:article)

      expect(Article.serialize_to_api(order: :asc)).to eq(
        {
          data: [
            {
              id: first_article.id,
              type: 'article',
              attributes:
              {
                title: first_article.title,
                content: first_article.content,
                slug: first_article.slug
              }
            },
            {
              id: second_article.id,
              type: 'article',
              attributes:
              {
                title: second_article.title,
                content: second_article.content,
                slug: second_article.slug
              }
            }
          ]
        })
    end
  end
end
