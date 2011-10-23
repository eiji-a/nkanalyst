# -*- coding: utf-8 -*-
class PlController < ApplicationController

  

  def monthly
    load_month_siten(params)
    if @month == nil || @siten == nil

    end
    lmon = @month.last_year
    @zennen  = Zisseki.load(lmon, @siten)
    @zisseki = Zisseki.load(@month, @siten)
    @yosan   = Yosan.load(@month, @siten)
    @keiri   = Keiripl.load(@month, @siten)
    @title = "#{@month.year}年度#{@month.mm}月度実績: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  # 実績更新
  def zedit
    load_month_siten(params)
    @zisseki = Zisseki.load(@month, @siten)
    @title = "[更新] #{@month.year}年度#{@month.mm}月度実績: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def zupdate
    m = Month.find(params[:zisseki][:month_id])
    pr = {:id => params[:zisseki][:siten_id], :month => m.month}
    load_month_siten(pr)
    @zisseki = Zisseki.load(@month, @siten)
    respond_to do |format|
      if @zisseki.update_attributes(params[:zisseki])
        flash[:notice] = "実績が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @month.month) }
      else
        format.html { render :action => "zedit" }
      end
    end
  end

  # 予算更新
  def yedit
    load_month_siten(params)
    @yosan = Yosan.load(@month, @siten)
    @title = "[更新] #{@month.year}年度#{@month.mm}月度予算: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def yupdate
    m = Month.find(params[:yosan][:month_id])
    pr = {:id => params[:yosan][:siten_id], :month => m.month}
    load_month_siten(pr)
    @yosan = Yosan.load(@month, @siten)
    respond_to do |format|
      if @yosan.update_attributes(params[:yosan])
        flash[:notice] = "予算が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @month.month) }
      else
        format.html { render :action => "yedit" }
      end
    end
  end

  # 経理更新
  def kedit
    load_month_siten(params)
    @keiri = Keiripl.load(@month, @siten)
    @title = "[更新] #{@month.year}年度#{@month.mm}月度経理: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def kupdate
    m = Month.find(params[:keiripl][:month_id])
    pr = {:id => params[:keiripl][:siten_id], :month => m.month}
    load_month_siten(pr)
    @keiri = Keiripl.load(@month, @siten)
    respond_to do |format|
      if @keiri.update_attributes(params[:keiripl])
        flash[:notice] = "予算が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @month.month) }
      else
        format.html { render :action => "kedit" }
      end
    end
  end

:private

  def load_month_siten(params)
    @siten = Siten.find(params[:id])
    @month = nil
    begin
      @month = Month.load(params[:month])
    end
  end
end
