class PurchaseController < ApplicationController
  require 'payjp'
  before_action :set_card, only: [:index, :pay, :done]
  before_action :set_item

  def index
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      # redirect_to controller: "cards", action: "new", notice: "お支払い用のクレジットカードを登録して下さい"
      render "index.error"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    # @item = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => @card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    if @item.pay?
      redirect_to action: 'done' #完了画面に移動
    else
      redirect_to action: 'index',notice:"購入出来ませんでした"
    end
  end

  def done
      @product_purchaser = Item.find(params[:item_id])
      @product_purchaser.update( buyer_id: current_user.id)

  end

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item
  @item = Item.find(params[:item_id])
  end

end
