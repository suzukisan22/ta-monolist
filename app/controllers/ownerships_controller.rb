class OwnershipsController < ApplicationController
  before_action :require_user_logged_in
  before_action :check_type_params

  def create
    @item = Item.find_or_initialize_by(code: params[:item_code])

    unless @item.persisted?
      results = RakutenWebService::Ichiba::Item.search(itemCode: @item.code)

      @item = Item.new(read(results.first))
      @item.save
    end

    create_ownership(params[:type])

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item = Item.find(params[:item_id])
    destroy_ownership(params[:type])
    redirect_back(fallback_location: root_path)
  end

  private

  def create_ownership(type)
    current_user.send(type.downcase, @item)
    flash[:success] = "商品の#{type}しました。"
  end

  def destroy_ownership(type)
    current_user.send("un#{type.downcase}", @item)
    flash[:success] = "商品の#{type}を解除しました。"
  end

  def check_type_params
    unless Ownership::OWNERSHIP_OPTIONS.include?(params[:type])
      redirect_back(fallback_location: root_path)
    end
  end
end
