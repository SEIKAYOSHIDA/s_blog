class PostsController < ApplicationController
  #before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  def index
    @posts = Post.all.order(created_at: :asc)
  end
  
  def show
    @post = Post.find_by(id: params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(
      content: params[:content],
      image_url: "default_post.jpg")
   if @post.save
    flash[:notice]="投稿を作成しました"
    redirect_to("/posts/index")
   else
    render("posts/new")
   end
  end
  
  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
  
    if @post.save
      if params[:image]
        @post.image_url="#{@post.id}.jpg"
        @post.save
        file= params[:image]
        File.open("public/post_images/#{@post.image_url}", 'wb') { |f|
          f.write(file.read)
        }
        
        #File.binwrite("public/post_images/#{@post.image_url}", "w+b")
      end
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end
  
  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end
  
  #def ensure_correct_user
    #@post = Post.find_by(id: params[:id])
    #if @current_user.id != params[:id]
      #flash[:notice] = "権限がありません"
      #redirect_to("/posts/index")
    #end
  #end
end