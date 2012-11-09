class UploadController < ApplicationController
	protect_from_forgery :except => :upload

	# POST /upload
	# POST /upload.json
	respond_to :json
	  def upload
	    @upload = Upload.new
	    @upload.save
	    @user = current_user
	    respond_with do |format|
	    	@upload.update_attribute(:user_id, 1)
	    	@upload.update_attribute(:tag_steps, 3000)
	    	format.json { head :ok }
	    end

	    # save user_point
	      user_point = UserPoint.new
	      user_point.add_point(@upload.user_id, @upload.tag_steps, 'steps')

	    # save team_point
          team_point = TeamPoint.new
          team = Team.find_by_user1(@upload.user_id)
          team_point.add_point(team.id, @upload.tag_steps)
	  end


end