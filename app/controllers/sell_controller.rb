class SellController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.images.build
    # @item.item_categories.build
    @item.brands.build
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      params[:images][:image].each do |image|
        @item.images.create!(image: image, item_id: @item.id)
      end
      redirect_to root_path, notice: "出品しました"
      else
    end
  end

  def finish
    
  end


  private
  def item_params
    params.require(:item).permit(
      :name,
      :price,
      :description,
      :date,
      :status,
      :burden,
      :send_method,
      # :region,
      :category,
      brands_attributes: [:name],
      images_attributes: [:image])
      # .merge(seler_id: current_user.id)
  end
  def set_params
    @item = Item.find(params[:id])
  end
end
