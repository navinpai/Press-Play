class PlaylistsController < ApplicationController
  before_filter :authenticate_user! , :except=> [:show, :index]
  # GET /playlists
  # GET /playlists.xml
  def index
    @playlists = Playlist.all.paginate :page => params[:page], :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlists }
    end
  end
  
    def myplaylists
    @playlists = Playlist.where(:user_id =>current_user.id).paginate :page => params[:page], :per_page => 5

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playlists }
    end
  end

  # GET /playlists/1
  # GET /playlists/1.xml
  def show
        @playlist = Playlist.find(params[:id])
		@playlistpath="public/playlists/"+@playlist.id.to_s+".xml"
		@connections=Connection.where(:playlist_id => @playlist)
		file = File.new(@playlistpath, "w")
		xml = Builder::XmlMarkup.new :target => file
		xml.instruct! :xml, :version=>"1.0"  
		xml.songs{
		for connection in @connections do
		@songs=Song.where(:id => connection.song_id)
		for song in @songs do
		xml.song("path" => song.songfile_url.to_s, "title" => song.title)
		end
		end
		}
		file.close
	
	#respond_to do |format|
     # format.html # show.html.erb
      #format.xml  { render :xml => @playlist }
    #end
  end

  # GET /playlists/new
  # GET /playlists/new.xml
  def new
    @playlist = Playlist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /playlists
  # POST /playlists.xml
  def create
    @playlist = Playlist.new(params[:playlist])

    respond_to do |format|
      if @playlist.save
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully created.') }
        format.xml  { render :xml => @playlist, :status => :created, :location => @playlist }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.xml
  def update
    @playlist = Playlist.find(params[:id])

    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to(@playlist, :notice => 'Playlist was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playlist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.xml
  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to(playlists_url) }
      format.xml  { head :ok }
    end
  end
  
    def gen_xml
		file = File.new("public/playlist.xml", "w")
		xml = Builder::XmlMarkup.new :target => file
		@songs=Song.find(:all)
		xml.instruct! :xml, :version=>"1.0"  
		xml.songs{
		for song in @songs do
		xml.song("path" => song.songfile_url.to_s, "title" => song.title)
		end
		}
		file.close
	  end
end
