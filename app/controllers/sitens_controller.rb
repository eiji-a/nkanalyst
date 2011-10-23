# -*- coding: utf-8 -*-
class SitensController < ApplicationController
  def index
    @sitens = Siten.find(:all)
    @title = '支店管理: 一覧'

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @sitens }
    end
  end

  def new
    @siten = Siten.new
    @title = '支店管理: 新規作成'

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
    @siten = Siten.new(params[:id])
    @title = '支店管理: 更新(' + @siten.name + ')'
    
    respond_to do |format|
      format.html
    end
  end

  def delete
  end

end
