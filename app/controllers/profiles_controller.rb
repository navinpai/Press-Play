class ProfilesController < ApplicationController
  def new
    super
    @user.profile = Profile.new
  end

  def create
    super
    @profile = @user.profiles.build(params[:profile])
      if @profile.save
      flash[:notice] = "Profile written"
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
    def show
    @profile = Profile.find(params[:id])
	@user=User.find(@profile.id)
	@artists=Artist.all
	@songs=Song.where(:user_id => params[:id]).paginate :page => params[:page], :per_page => 5
	@playlists=Playlist.where(:user_id => params[:id]).paginate :page => params[:page], :per_page => 5
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end
  
    def edit
    @profile = Profile.find(params[:id])
  end
  
    def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

end