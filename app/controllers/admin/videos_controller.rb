class Admin::VideosController < AdminsController
  before_filter :require_user

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      flash[:success] = "You have successfully added the video '#{@video.title}'."
      redirect_to new_admin_video_path
    else
      flash[:danger] = "You cannot add this video. Please check the errors."
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit!
  end
end