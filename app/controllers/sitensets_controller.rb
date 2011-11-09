# -*- coding: utf-8 -*-
class SitensetsController < ApplicationController

  # 支店セット

  def index
    @sets = SitenSet.find(:all)
    @title = '支店セット: 一覧'

    respond_to do |format|
      format.html
    end
  end

  def show
    @set = SitenSet.find(params[:id])
    @title = '支店セット: 詳細'
    @detail = SitenSetDetail.new
    @sitens = Siten.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def new
    @sitenset = SitenSet.new
    @title = '支店セット: 新規作成'

    respond_to do |format|
      format.html
    end
  end

  def create
    mon = params[:siten_set][:startmonth]
    params[:siten_set][:startmonth] = Month.month2serial(mon.to_i)
    @set = SitenSet.new(params[:siten_set])

    respond_to do |format|
      if @set.save
        flash[:notice] = "支店セット [#{@set.name}] が作成されました"
        format.html { redirect_to(:action => :index) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    @sitenset = SitenSet.find(params[:id])
    @title = '支店セット: 更新'

    respond_to do |format|
      format.html
    end
  end

  def update
    mon = params[:siten_set][:startmonth]
    params[:siten_set][:startmonth] = Month.month2serial(mon.to_i)
    @set = SitenSet.find(params[:id])

    respond_to do |format|
      if @set.update_attributes(params[:siten_set])
        flash[:notice] = "支店セット [#{@set.name}] が更新されました"
        format.html { redirect_to(:action => :index) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def add_detail
    @set = SitenSet.find(params[:id])
    @detail = SitenSetDetail.new(params[:siten_set_detail])
    @detail.siten_set = @set

    respond_to do |format|
      if @detail.save
        flash[:notice] = "支店セット詳細 [#{@detail.sequence}]が追加されました"
        format.html { redirect_to(:action => :show, :id => @set.id) }
      else
        format.html { render :action => :show }
      end
    end
  end

  def edit_detail
    @set = SitenSet.find(params[:id])
    @sitens = Siten.find(:all)
    @detail = SitenSetDetail.find(params[:siten_set_detail_id])
    @title = '支店セット: 詳細更新'

    respond_to do |format|
      format.html
    end
  end

  def update_detail
    @set = SitenSet.find(params[:id])
    @detail = SitenSetDetail.find(params[:siten_set_detail][:id])

    respond_to do |format|
      if @detail.update_attributes(params[:siten_set_detail])
        flash[:notice] = "支店セット詳細 [#{@detail.sequence}]が更新されました"
        format.html { redirect_to(:action => :show, :id => @set.id) }
      else
        format.html { render :action => :show }
      end
    end
  end
end
