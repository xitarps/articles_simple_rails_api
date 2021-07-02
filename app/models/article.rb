class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  def self.serialize_to_api(order: :desc)
    { data: Article.order(id: order).map { |art| art.serialize_attributes } }
  end

  def serialize_to_api
    { data: self.serialize_attributes }
  end

  def serialize_attributes
    {
      type: 'article',
      id: id.to_s,
      attributes: {
        title: title,
        content: content,
        slug: slug
      }
    }
  end
end
