class Api::V1::ArticlesController < Api::V1::CustomApiController
  def index
    articles = Article.all.map { |article| { type: 'articles',
                                             id: article.id,
                                             attributes: {
                                               title: article.title,
                                               content: article.content,
                                               slug: article.slug
                                             }}}
    data = { data: articles }
    render json: data
  end

  def show

    article = Article.find(params[:id]) 

    data = { data: 
              { type: 'articles',
                id: article.id,
                attributes: {
                title: article.title,
                content: article.content,
                slug: article.slug
                }}}

    render json: data
  end
end
