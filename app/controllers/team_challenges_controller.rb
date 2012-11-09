
class TeamChallengesController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:create, :team_challenge_list]

#----------------------------------------------------------authenticate_admin-----------------------------------------------
  # GET /team_challenges
  # GET /team_challenges.json
  def index
    @team_challenges = TeamChallenge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @team_challenges }
    end
  end

  # GET /team_challenges/1
  # GET /team_challenges/1.json
  def show
    @team_challenge = TeamChallenge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @team_challenge }
    end
  end

  # GET /team_challenges/new
  # GET /team_challenges/new.json
  def new
    @team_challenge = TeamChallenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @team_challenge }
    end
  end

  # GET /team_challenges/1/edit
  def edit
    @team_challenge = TeamChallenge.find(params[:id])
  end

  # PUT /team_challenges/1
  # PUT /team_challenges/1.json
  def update
    @team_challenge = TeamChallenge.find(params[:id])

    respond_to do |format|
      if @team_challenge.update_attributes(params[:team_challenge])
        format.html { redirect_to @team_challenge, :notice => 'Team challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @team_challenge.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_challenges/1
  # DELETE /team_challenges/1.json
  def destroy
    @team_challenge = TeamChallenge.find(params[:id])
    @team_challenge.destroy

    respond_to do |format|
      format.html { redirect_to team_challenges_url }
      format.json { head :no_content }
    end
  end

#----------------------------------------------------------authenticate_user------------------------------------------------------
  # POST /team_challenges
  # POST /team_challenges.json
  # create
  #   INPUT: challenge_message.id (value)
  #   OUTPUT: SAVE team_challenge (TeamChallenge.object)
  #   FROM: views/challenge_messages/inbox_list
  #   TO:
  #   2012.7.15 Yueying
  def create
    # accept
    if params[:accept]
      # create team_challenge
      team_challenge = TeamChallenge.new
      challenge_message_id = nil
      hash = params[:accept]
      if hash != nil
        hash_invert = hash.invert
        challenge_message_id = hash_invert.values_at("accept").first.to_i
      end
      challenge_message = ChallengeMessage.find(challenge_message_id)
      team_challenge.sender_team_id = challenge_message.sender_team_id
      team_challenge.receiver_team_id = challenge_message.receiver_team_id
      team_challenge.datetime = challenge_message.datetime
      team_challenge.location = challenge_message.location
      team_challenge.save
  
      # create challenge_message (message_type = 2)
      challenge_message2 = ChallengeMessage.new
      challenge_message2.user_id = current_user.id
      challenge_message2.sender_team_id = team_challenge.receiver_team_id
      challenge_message2.receiver_team_id = team_challenge.sender_team_id
      challenge_message2.message_type = 2
      challenge_message2.save
    end

    # reject
    if params[:reject]
      # create challenge_message (message_type = 3)
      challenge_message_id = nil
      hash = params[:reject]
      if hash != nil
        hash_invert = hash.invert
        challenge_message_id = hash_invert.values_at("reject").first.to_i
      end

      challenge_message3 = ChallengeMessage.new
      challenge_message3.user_id = current_user.id
      challenge_message3.sender_team_id = ChallengeMessage.find(challenge_message_id).receiver_team_id
      challenge_message3.receiver_team_id = ChallengeMessage.find(challenge_message_id).sender_team_id
      challenge_message3.message_type = 3
      challenge_message3.save
    end
    redirect_to '/admin/home'
  end

  # team_challenge_list
  #   INPUT: user_id (session value)
  #   OUTPUT: team_challenge (TeamChallenge.object)
  #   FROM: views/challenge_messages/home
  #   TO: views/team_challenges/team_challenge_list
  #   2012.7.15 Yueying
  def team_challenge_list
    @team_challenges = TeamChallenge.find_by_user(current_user.id)
  end

end
