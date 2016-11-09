class AdminController < ApplicationController
	before_filter :authenticate_user!
	def index
		if params[:category].blank?
			@article = Article.all.order('created_at DESC')
		else
			@category_id = Category.find_by(name: params[:category]).id 
			puts @category_id
			@article = Article.where(category_id: @category_id).order('created_at DESC')
		end
	end
	def show
		@users = User.all.order('id ASC')
		render 'manage'
	end
	def manage
		
	end

	def make_admin
		user = User.find(params[:id])
		user.update(admin: true)
		redirect_to root_path
	end
	def unmake_admin
		user = User.find(params[:id])
		user.update(admin: false)
		redirect_to root_path
	end
	def destroy
		User.find(params[:id]).destroy
		redirect_to '/admin/manage'
	end

end

