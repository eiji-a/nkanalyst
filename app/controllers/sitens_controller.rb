# -*- coding: utf-8 -*-
class SitensController < ApplicationController
  def index
    @sitens = Siten.find(:all)
    @title = '支店: 一覧'

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @sitens }
    end
  end

  def new
    @siten = Siten.new
    @title = '支店: 新規作成'

    respond_to do |format|
      format.html
    end
  end

  def create
    @siten = Siten.new(params[:siten])

    respond_to do |format|
      if @siten.save
        flash[:notice] = "支店 [#{@siten.name}] が作成されました"
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def edit
    @siten = Siten.find(params[:id])
    @title = '支店: 更新(' + @siten.name + ')'
    
    respond_to do |format|
      format.html
    end
  end

  def update
    @siten = Siten.find(params[:id])

    respond_to do |format|
      if @siten.update_attributes(params[:siten])
        flash[:notice] = "支店 [#{@siten.name}] が更新されました"
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def delete
  end

end
