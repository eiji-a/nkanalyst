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
    @set = SitenSet.new(params[:siten_set])

    respond_to do |format|
      if @set.save
        flash[:notice] = "支店セット [#{@set.name}] が作成されました"
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def new_detail
    @set = SitenSet.find(params[:id])
    @detail = SitenSetDetail.new

    respond_to do |format|
      format.html
    end
  end

end
