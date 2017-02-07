class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def create
		@article = Article.new(article_params)
		@article.save
		render :show
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		Article.destroy(params[:id])
	end
 
private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
