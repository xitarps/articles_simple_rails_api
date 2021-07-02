class Api::V1::ArticlesController < Api::V1::CustomApiController
  def index
    articles = Article.serialize_to_api
    render json: articles
  end

  def show

    article = Article.find(params[:id]).serialize_to_api

    render json: article
  end
end
