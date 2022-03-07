class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :update, :destroy]

  def index
    @articles = Article.all
    render json:@articles
  end

  def create
    @new_article = Article.new(article_params)
    if @new_article.save
      redirect_to api_v1_articles_path
    end
  end

  def show
    if @article
      render json:@article
    else
      render json: { error: "Couldn't find article with id #{params[:id]}" }
    end
  end

  def update
    if @article
      @article.update(article_params)
      redirect_to api_v1_article_path(@article)
    else
      render json: { error: "Couldn't find article with id #{params[:id]}" }
    end
  end

  def destroy
    if @article
      a = Array.new
      @article.comments.each do |ac|
        a.push(ac.id)
      end
      @article.destroy
      render json: { message:"Successfully deleted article with id #{@article.id} and also its comments with ids #{a}" }, status: 200
    else
      render json: { error: "Couldn't find article with id #{params[:id]}" }
    end
  end

  def search_article
    if params[:query].empty? || params[:query].length < 3
        render json: { error: "Please enter atleast 3 character to search" }
    else
        @article = Article.where("title LIKE '%#{params[:query]}%'")
        if @article.present?
            render json:@article
        else
            render json: { error: "Sorry!No match Found" }
        end
    end
  end

  private
  def article_params
    params.permit(:title, :body, :release_date)
  end

  def find_article
    @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @article = nil
  end
end
