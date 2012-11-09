
class ChallengeMessagesController < ApplicationController
  # devise gem
  # 2012.7.28 Yueying
  before_filter :authenticate_admin!, :only => [:index, :show, :new, :edit, :update, :destroy]
  before_filter :authenticate_user!, :only => [:new_invite, :new_reply, :create, :inbox_list, :sentbox_list, :home]

#--------------------------------------------------------authenticate_admin-----------------------------------------------------------
  # GET /challenge_messages
  # GET /challenge_messages.json
  def index
    @challenge_messages = ChallengeMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @challenge_messages }
    end
  end

  # GET /challenge_messages/1
  # GET /challenge_messages/1.json
  def show
    @challenge_message = ChallengeMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @challenge_message }
    end
  end

  # GET /challenge_messages/new
  # GET /challenge_messages/new.json ---no use---
  def new
    @receiver_team_id = params[:id]
    @type = params[:type]
    @challenge_message = ChallengeMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @challenge_message }
    end
  end

  # GET /challenge_messages/1/edit
  def edit
    @challenge_message = ChallengeMessage.find(params[:id])
  end

  # PUT /challenge_messages/1
  # PUT /challenge_messages/1.json
  def update
    @challenge_message = ChallengeMessage.find(params[:id])

    respond_to do |format|
      if @challenge_message.update_attributes(params[:challenge_message])
        format.html { redirect_to @challenge_message, :notice => 'Challenge message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @challenge_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_messages/1
  # DELETE /challenge_messages/1.json
  def destroy
    @challenge_message = ChallengeMessage.find(params[:id])
    @challenge_message.destroy

    respond_to do |format|
      format.html { redirect_to challenge_messages_url }
      format.json { head :no_content }
    end
  end

#--------------------------------------------------------authenticate_user-----------------------------------------------------------
  # GET /challenge_messages/new
  # GET /challenge_messages/new.json
  # new_invite
  #   INPUT: receiver_team_id (value)
  #   OUTPUT: 
  #   FROM: views/teams/team_information_list
  #   TO: views/challenge_messages/_form
  #   2012.7.12 Yueying
  def new_invite
    # only allow send challenge invitation to the same team once a week
    sender_team_id = Team.find_by_user1(current_user.id).id
    @receiver_team_id = params[:id]
    start_date_of_current_week = Time.now.beginning_of_week
    end_date_of_current_week = Time.now.end_of_week
    date_range = (start_date_of_current_week..end_date_of_current_week)
    challenge_message_ids = ChallengeMessage.find_by_sql("SELECT challenge_messages.id FROM challenge_messages WHERE challenge_messages.sender_team_id = " + sender_team_id.to_s + " AND challenge_messages.receiver_team_id = " + @receiver_team_id.to_s + " AND challenge_messages.message_type = 0")
    if challenge_message_ids == nil
    else
      challenge_messages = ChallengeMessage.find_all_by_id(challenge_message_ids)
      challenge_messages.each do |challenge_message|
        if date_range.cover?(challenge_message.created_at)
          flash[:notice_challenge_constrain] = 'you have already sent a challenge invitation to this team in this week, you can try it again in the next week.'
          flash.keep(:notice_challenge_constrain)
          redirect_to '/teams/team_information_list', :notice_challenge_constrain => 'you have already sent a challenge invitation to this team in this week, you can try it again in the next week.'
        end
      end
    end
    
    # show form
    @message_type = 0
    @challenge_message = ChallengeMessage.new
  end

  # GET /challenge_messages/new
  # GET /challenge_messages/new.json
  # new_reply
  #   INPUT: receiver_team_id (value)
  #   OUTPUT: 
  #   FROM: views/challenge_messages/challenge_message_list
  #   TO: views/challenge_messages/_form
  #   2012.7.12 Yueying
  def new_reply
    challenge_message = ChallengeMessage.find(params[:id])
    @receiver_team_id = Team.find_by_id(challenge_message.sender_team_id).id
    @old_challenge_message_id = challenge_message.id
    @message_type = 1
    @challenge_message = ChallengeMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @challenge_message }
    end
  end

  # POST /challenge_messages
  # POST /challenge_messages.json
  # create
  #   INPUT: datetime, location (value)
  #   OUTPUT: SAVE
  #   FROM: /views/challenge_messages/new->_form
  #   TO:
  #   2012.7.13 Yueying
  def create
    # save challenge_message
    challenge_message = ChallengeMessage.new(params[:challenge_message])
    challenge_message.sender_team_id = Team.find_by_user1(current_user.id).id
    challenge_message.user_id = current_user.id

    challenge_message.save

    # if from /views/challenge_message/_form_reply = create "reply message"
    # reset the old challenge_message's is_read = 1
    if params[:old_challenge_message_id] != nil
      old_challenge_message = ChallengeMessage.find(params[:old_challenge_message_id])
      old_challenge_message.update_attribute(:is_read, 1)
    end

    redirect_to '/admin/home'
  end

  # inbox_list
  #   INPUT: user_id (session value)
  #   OUTPUT: challenge_messages (ChallengeMessage.objects)
  #   FROM: /views/challenge_messages/home
  #   TO: /views/challenge_messages/inbox_list
  #   2012.7.12 Yueying
  def inbox_list
    @challenge_messages = ChallengeMessage.find_inbox_by_user(current_user.id)
  end

  # sentbox_list
  #   INPUT: user_id (session value)
  #   OUTPUT: challenge_messages (ChallengeMessage.objects)
  #   FROM: /views/challenge_messages/home
  #   TO: /views/challenge_messages/sentbox_list
  #   2012.7.15 Yueying
  def sentbox_list
    @challenge_messages = ChallengeMessage.find_sentbox_by_user(current_user.id)
  end

#-----------------------------------------home-----------------------------------------------------
  # home ##top##
  #   FROM: views/teams/home1
  #   INCLUDE VIEWS: /views/team_challenges/team_challenge_list, /views/challenge_messages/inbox_list, /views/challenge_messages/sentbox_list
  #   INCLUDE CONTROLLERS: /controllers/team_challenges_controller/team_challenge_list, /controllers/challenge_messages_controller/inbox_list, /controllers/challenge_messages_controller/sentbox_list
  #   2012.7.21 Yueying
  def home
    # /controllers/team_challenges_controller/team_challenge_list
    @team_challenges = TeamChallenge.find_by_user(current_user.id)

    # /controllers/challenge_messages_controller/inbox_list
    @challenge_messages_inbox = ChallengeMessage.find_inbox_by_user(current_user.id)

    # /controllers/challenge_messages_controller/sentbox_list
    @challenge_messages_sentbox = ChallengeMessage.find_sentbox_by_user(current_user.id)
  end
end
