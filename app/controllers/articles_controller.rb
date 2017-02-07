class ArticlesController < ApplicationController
  def index
    @articles = Article.where(author_id: current_user)
  end

  def create
    if current_user.nil?
      render json: {'error': 'Need a user to create an article'}, status: 401
      return
    end

    @article = Article.new(article_params)
    @article.author = current_user
    if @article.save
      render :show
    else
      render json: {'errors': @article.errors.full_messages}, status: 400
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.author == current_user
      if @article.update(article_params)
        render :show
      else
        render json: {'errors': @article.errors.full_messages}, status: 400
      end
    else
      render json: {'error': 'You cannot edit this'}, status: 401
    end
  end

  def destroy
    unless current_user
      render json: {'error': 'You do not have permission'}, status: 401
      return
    end

    article = Article.find_by(id: params[:id])
    if current_user && article && article.author == current_user
      Article.destroy(params[:id])
    end
  end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
