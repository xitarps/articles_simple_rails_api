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
end
