class RoomsController < ApplicationController
	# before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def index
  	@rooms = Room.all
  end

  def new
  	@room = Room.new
  end

  def create
  	@room = Room.new(room_params)
  	@room.user_id = current_user.id
  		if @room.save
  			redirect_to @room
  		end
  end

  def show 
    @booking = Booking.new
    @special_price = SpecialPrice.new
  end
  
  def destroy
    if @room.destroy
      redirect_to rooms_path,  notice: "Successfully deleted the room"
    end
  end
  
  def update
    if @room.update_attributes(params[:room].permit(:name, :description, :price, :rules,:address, :is_authorized))
      if @room.is_authorized == true
      Notification.room_auth(@room).deliver!
      redirect_to rooms_path, notice: "authorized the room"
      else
        redirect_to rooms_path, notice: "Successfully updated the room"
      end
    else
      render action: "edit"
    end
  end
  
  def edit

  end

  def authorization_rooms
    @rooms = Room.where('is_authorized = ?', false)
  end

  def my_rooms
    @rooms = current_user.rooms
  end

  private 
  def room_params
  	params.require(:room).permit(:name,:description,:price,:rules,:images,:address,:latitude,:longitude,:city_id,:user_id,amenity_ids:[])
  end
  def set_room
      @room = Room.find(params[:id])
    end
end


