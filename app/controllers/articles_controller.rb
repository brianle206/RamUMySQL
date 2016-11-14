class ArticlesController < ApplicationController
	before_action :find_article, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show, :landing, :search]
	
	include MarkdownHelper 
	include DashboardHelper

	def landing
	end
	
	def index
		if params[:category].blank?
			@article = Article.all.order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@article = Article.where(category_id: @category_id).order("created_at DESC")
		end
	end

	def show
	end

	def new 
		@article = current_user.articles.build
	end

	def create
		@article = current_user.articles.build(article_parmas)
		if @article.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(article_parmas)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def search
		@article = Article.search(params[:search])
		puts @article
		render action: 'index'
	end

	def destroy
		@article.destroy
		redirect_to root_path
	end

	private 

	def article_parmas
 		params.require(:article).permit(:title, :content, :category_id)
 	end
	
	def find_article
		@article = Article.find(params[:id])
	end
	
end
