class CommentsController < ApplicationController
   
	before_action :comment_auth, only: [:destroy]
	
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:name, :body))
		#redirect_to post_path(@post)
		@comment.user_id=current_user.id if current_user
		@comment.save

		if @comment.save
			redirect_to post_path(@post)
		else
			render '_comment'
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private

	def comment_auth
		if current_user != @post.user
			redirect_to(root_path)
		end
	end

end
