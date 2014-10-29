
class TopicsController < ApplicationController
  def index
     @topics = Topic.paginate(Topic.visible_to(current_user), params[:page] || 1, 10)
     authorize @topics
     @page = params[:page].to_i
     @topics_count = Topic.visible_to(current_user).count
  end

  def new
     @topic = Topic.new
     authorize @topic
  end

  def show
     @topic = Topic.find(params[:id])
     authorize @topic
     @posts = Post.paginate(@topic.posts.includes(:user).includes(:comments), params[:page] || 1, 10)
     @posts_count = @topic.posts.includes(:user).count
  end

  def edit
     @topic = Topic.find(params[:id])
     authorize @topic
  end
 
   def create
     @topic = Topic.new(topic_params)
     authorize @topic
     if @topic.save
       redirect_to @topic, notice: "Topic was saved successfully."
     else
       flash[:error] = "Error creating topic. Please try again."
       render :new
     end
   end
 
   def update
     @topic = Topic.find(params[:id])
     authorize @topic
     if @topic.update_attributes(topic_params)
       redirect_to @topic
     else
       flash[:error] = "Error saving topic. Please try again"
       render :edit
     end
   end

   def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name

    authorize @topic
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted succesffully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end
  

  private 

  def topic_params
  params.require(:topic).permit(:name, :description, :public)
  end
end