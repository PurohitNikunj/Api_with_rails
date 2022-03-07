class Api::V1::CommentsController < ApplicationController
    before_action :find_article
    before_action :find_comment, only: [:show, :update, :destroy]

    def index
        if @article
            @comments = @article.comments
            render json:@comments
        else
            render json: { error: "Couldn't find article with id #{params[:article_id]}" }
        end
    end

    def create
        if @article
            @comment = @article.comments.new(comment_params)
            if @comment.save
                redirect_to api_v1_article_comments_path
            end
        else
            render json: { error: "Couldn't find article with id #{params[:article_id]}" }
        end
    end

    def show
        if @comment
            render json:@comment
        else
            render json: { error: "Couldn't find comment with id #{params[:id]}" }
        end
    end

    def update
        if @comment
            @comment.update(comment_params)
            redirect_to api_v1_article_comment_path(@article, @comment)
        else
            render json: { error: "Couldn't find comment with id #{params[:id]}" }
        end
    end

    def destroy
        if @comment
            @comment.destroy
            render json: { message: "Successfully deleted comment with id #{@comment.id}" }
        else
            render json: { error: "Couldn't find comment with id #{params[:id]}" }
        end
    end

    def search_comment
        if params[:query].empty? || params[:query].length < 3
            render json: { error: "Please enter atleast 3 character to search" }
        else
            @comment = Comment.where("comment LIKE '%#{params[:query]}%'")
            if @comment.present?
                render json:@comment
            else
                render json: { error: "Sorry!No match Found" }
            end
        end
    end

    private
    def comment_params
        params.permit(:comment, :date_of_comment)
    end

    def find_comment
        if @article
            @comment = @article.comments.find(params[:id])
        else
            render json: { error: "Couldn't find article with id #{params[:article_id]}" }
        end
        rescue ActiveRecord::RecordNotFound
          @comment = nil
    end

    def find_article
        @article = Article.find(params[:article_id])
        rescue ActiveRecord::RecordNotFound
          @article = nil
    end
end
