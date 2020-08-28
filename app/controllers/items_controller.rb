class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :edit, :destroy, :update]

  def index
    @items = Item.includes(:images).order('created_at DESC')
    @items_index = @items.order(updated_at: :desc).page(params[:page]).per(4)
    @parents = Category.where(ancestry: nil)
    @ladies = Category.find(1).subtree
    @ladies_items = Item.where(category_id: @ladies)
    @last_ladies_item = @ladies_items.last
    @mens = Category.find(196).subtree
    @mens_items = Item.where(category_id: @mens)
    @last_mens_item = @mens_items.last
    @babies = Category.find(327).subtree
    @babies_items = Item.where(category_id: @babies)
    @last_babies_item = @babies_items.last
    @hobbies = Category.find(661).subtree
    @hobbies_items = Item.where(category_id: @hobbies)
    @last_hobbies_item = @hobbies_items.last
    @appliances= Category.find(874).subtree
    @appliances_items = Item.where(category_id: @appliances)
    @last_appliances_item = @appliances_items.last
    
  end

  def new
    @item = Item.new
    @item.images.build
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @images = @item.images 
    @comments = @item.comments.includes(:user)
    @comment = @item.comments.build
  end

  def get_category_children
    @category_children = Category.find_by(id: params[:parent_name], ancestry: nil).children
  end

  def get_category_grandchildren
      @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
  def create
    @item = Item.new(item_params)
  
    if @item.save
      redirect_to root_path 
    else
      redirect_to new_item_path, notice: "商品情報を正確に入力して下さい"
    end  
  end

  def edit
    @parents = Category.where(ancestry: nil)
  end  

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to item_path(@item.id)
      flash.now[:aret] = '商品の削除ができませんでした'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      redirect_to edit_item_path, notice: '未入力があるため、更新ができませんでした'
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :post_content,
      :name,
      :explain,
      :status_id,
      :delivery_cost_id,
      :area_id,:brand,
      :limit_id,:price,
      :category_id,
      :buyer_id,
      images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  

end

