class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  def serialize_to_api
    { type: 'articles',
      id: id,
      attributes: {
        title: title,
        content: content,
        slug: slug
      }
    }
  end
end
