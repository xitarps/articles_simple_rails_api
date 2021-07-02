class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true

  def self.serialize_to_api(order: :desc)
    { data: Article.order(id: order).map { |article| { type: 'articles',
                                          id: article.id,
                                          attributes: {
                                            title: article.title,
                                            content: article.content,
                                            slug: article.slug
                                          }
                                        }
                            }
    }
  end

  def serialize_to_api
    { data:
      { type: 'articles',
        id: id,
        attributes: {
          title: title,
          content: content,
          slug: slug
        }
      }
    }
  end
end
