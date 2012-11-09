
class MentorMessagesController < ApplicationController

  before_filter :authenticate_admin!, :only => [:index, :edit, :update, :destroy]
  before_filter :authenticate_user_or_trainer, :only => [:new, :show, :create, :home]

#------------------------------------------authorization_admin----------------------------------
  # GET /mentor_messages
  # GET /mentor_messages.json
  def index
    @mentor_messages = MentorMessage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mentor_messages }
    end
  end

  # GET /mentor_messages/1
  # GET /mentor_messages/1.json
  def show
    @mentor_message = MentorMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mentor_message }
    end
  end

  # GET /mentor_messages/new
  # GET /mentor_messages/new.json
  #   2012.8.9 Yueying
  def new
    @mentor_message = MentorMessage.new
    @trainers = nil
    # user -> trainer
    if current_user != nil
      @trainers = Trainer.all
      #@trainers = Trainer.find_by_sport(current_user.id)
    # trainer -> user
    elsif curent_trainer != nil
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mentor_message }
    end
  end

  # GET /mentor_messages/1/edit
  def edit
    @mentor_message = MentorMessage.find(params[:id])
  end

  # PUT /mentor_messages/1
  # PUT /mentor_messages/1.json
  def update
    @mentor_message = MentorMessage.find(params[:id])

    respond_to do |format|
      if @mentor_message.update_attributes(params[:mentor_message])
        format.html { redirect_to @mentor_message, notice: 'Mentor message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mentor_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentor_messages/1
  # DELETE /mentor_messages/1.json
  def destroy
    @mentor_message = MentorMessage.find(params[:id])
    @mentor_message.destroy

    respond_to do |format|
      format.html { redirect_to mentor_messages_url }
      format.json { head :no_content }
    end
  end

#------------------------------------------authorization_user_or_trainer----------------------------------
  # POST /mentor_messages
  # POST /mentor_messages.json
  #   2012.8.9 Yueying
  def create
    # if user/trainer didn't complete the form!!!
    if params[:receiver_id] == "" or params[:subject] == "" or params[:content] == "create a message here..."
      if params[:receiver_id] == ""
        flash[:alert_receiver_id] = "please select an athlete"
      end
      if params[:subject] == ""
        flash[:alert_subject] = "please input a subject"
      end
      if params[:content] == "create a message here..."
        flash[:alert_content] = "please input a content"
      end
      redirect_to "/mentor_messages/home"
    # else user/trainer complete the form
    else
      mentor_message = MentorMessage.new(params[:mentor_message])
      mentor_message.content = params[:content]
      # user -> trainer
      if current_user != nil
        mentor_message.message_type = 0
        mentor_message.sender_id = current_user.id
        mentor_message.receiver_id = params[:receiver_id]
      # trainer -> user
      elsif current_trainer != nil
        mentor_message.message_type = 1
        mentor_message.sender_id = current_trainer.id
        mentor_message.receiver_id = params[:receiver_id]
      end

      mentor_message.save
      redirect_to '/mentor_messages/home'
    end
  end

  # home
  #   2012.8.9 Yueying
  def home
    # trainers -> compose pane
    @select_trainer = nil
    if params[:name] != "message"
      @select_trainer = params[:name]
    else
      @select_trainer = nil
    end

    # create
    @mentor_message = MentorMessage.new
    # initial value
    @trainers = nil
    @inbox_mentor_messages = nil
    @sentbox_mentor_messages = nil
    # user -> trainer: message_type = 0
    if current_user != nil
      @trainers = Trainer.all
      #@trainers = Trainer.find_by_sport(current_user.id)
      # inbox
      @inbox_mentor_messages = MentorMessage.find_inbox_by_user(current_user.id)
      # sentbox
      @sentbox_mentor_messages = MentorMessage.find_sentbox_by_user(current_user.id)
    # trainer -> user: message_type = 1
    elsif current_trainer != nil
      # inbox
      @inbox_mentor_messages = MentorMessage.find_inbox_by_user(current_trainer.id)
      # sentbox
      @sentbox_mentor_messages = MentorMessage.find_sentbox_by_user(current_trainer.id)
      render :layout => nil
    end
  end
end
