class ItemsController < ApplicationController

  before_action :set_item, only: [:index, :show, :edit, :destroy]
  def index
    @items = Item.find(set_item[:id]).limit(10).order('created_at DESC')
    @images = Image.find(set_item[:id])
    @image = Image.find(item_id: image_params)
  end
  def edit
    @item = Item.find(params[:id])
    @image = @item.images.build
    @image = Image.find(params[:id])
  end
  def show
    @category = Category.find(params[:id])
    @images = Image.where(item_id:@item.id)
    @image = @images
    @brand = Brand.find(params[:id])
    @user = User.find(params[:id])
  end
  def update
    if @item.user_id == current_user.id && @item.update
      chenge_item_items_path
    else
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
    @image = Image.find(params[:id])
    @images = @item.images
  end
  private
  def item_params
    params.require(:item).permit(:name,:price,:description,:status,:region,:burden,:date,:send_method,images_attributes: [:id,:image])
  end
end

