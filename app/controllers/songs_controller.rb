class SongsController < ApplicationController
  before_filter :authenticate_user! , :except=> [:show, :index, :search]
  
  # GET /songs
  # GET /songs.xml
  def index
    #@songs = Song.all
	@songs = Song.paginate :page => params[:page], :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @songs }
    end
  end

  # GET /songs/1
  # GET /songs/1.xml
  def show
    @connection=Connection.new
    @song = Song.find(params[:id])
    @artist = Artist.find(@song.artist_id)
	@creator=Profile.find(@song.user_id)        
		@playlistpath="public/songs/"+@song.id.to_s+".xml"
		@connections=Connection.where(:playlist_id => @playlist)
		file = File.new(@playlistpath, "w")
		xml = Builder::XmlMarkup.new :target => file
		xml.instruct! :xml, :version=>"1.0"  
		xml.songs{
		xml.song("path" => @song.songfile_url.to_s, "title" => @song.title)
		}
		file.close
    #respond_to do |format|
     # format.html # show.html.erb
      #format.xml  { render :xml => @song }
    end


  # GET /songs/new
  # GET /songs/new.xml
  def new
    @song = Song.new
	@artist=Artist.all.sort_by(&:name)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
	@artist = Artist.all.sort_by(&:name)
  end

  # POST /songs
  # POST /songs.xml
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to(@song, :notice => 'Song was successfully created.') }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.xml
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to(@song, :notice => 'Song was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.xml
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to(songs_url) }
      format.xml  { head :ok }
    end
  end
  	  
	def mysongs
    @songs = Song.where(:user_id =>current_user.id).paginate :page => params[:page], :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlists }
    end
  end
  
  	def search
    @songs = Song.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"])
.paginate :page => params[:page], :per_page => 5
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlists }
    end
  end
  
  
end
