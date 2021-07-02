class Api::V1::ArticlesController < Api::V1::CustomApiController
  def index
    articles = Article.all.map { |article| article.serialize_to_api }
    data = { data: articles }
    render json: data
  end

  def show

    article = Article.find(params[:id]) 

    data = { data: article.serialize_to_api }

    render json: data
  end
end
