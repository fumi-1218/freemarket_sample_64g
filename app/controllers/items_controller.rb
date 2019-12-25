class ItemsController < ApplicationController
  before_action :set_item, only: [:index, :show, :edit, :destroy, :buyscreen, :buyscreenitem]

  def index
    @items = Item.find(set_item[:id]).limit(10).order('created_at DESC')
    @images = Image.find(set_item[:id])
    @image = Image.find(item_id: image_params)
    @item = Item.find(set_item[:id])
    @item.update( buyer_id: current_user.id)
  end

  def edit
    @image = @item.images.build
  end

  def show
    @category = Category.find(params[:id])
    @images = Image.where(item_id:@item.id)
    @image = @images
    @brand = Brand.find(params[:id])
    @user = User.find(@item.seler_id)
  end

  def buyscreen
    @images = Image.where(item_id:@item.id)
    @image = @images[0]
    @addresses = Address.where(user_id: current_user.id)
    @address = @addresses[0]
    if @item.seler_id == current_user.id
      # redirect_to edit_item_path
    else
      @item.save
    end

    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
  def buyscreenitem

  end

  def update
    if @item.seler_id == current_user.id && @item.update
      chenge_item_items_path
    end
  end

  def destroy
    if @item.user_id == current_user.id && @item.destroy
      redirect_to mypage_index_path
    else
      redirect_to edit_item_path
    end
  end
  private
  def set_item
    @item = Item.find(params[:id])
  end

  def image_params
    @image = Image.find(params[:id])
  end

  def chenge_item
    @item = Item.find(params[:id])
    @images = @item.images
  end

  private
  def item_params
    params.require(:item).permit(:name,:price,:description,:status,:region,:burden,:date,:send_method,images_attributes: [:id,:image])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end

