# -*- coding: utf-8 -*-
class PlController < ApplicationController

  

  def monthly
    load_siten(params)
    if @siten == nil

    end

    load_month(@serial, @siten)
    @uriage = @zisseki.uriage
    @curiage = @czisseki.uriage
    y, m = Month.yyyy_mm(@serial)
    @title = "#{y}年#{m}月度実績: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def yearly
    load_year_siten(params)
    if @year == nil || @siten == nil
    end
    @zisseki = Zisseki.load_12months(@year, @siten)
    @zyearly = Zisseki.load_yearly(@year, @siten)
    @title = "#{@year}年度実績: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end
=begin
  def analysys
    load_siten(params)
    if @siten == nil

    end
    load_month(serial, siten)
    @yzisseki = Zisseki.load_12months(@year, @siten)
    @yyearly  = Zisseki.load_yearly(@year, @siten)
    @
  end
=end

  def load_month(serial, siten)
    @zennen  = Zisseki.load(Month.last_year(serial), siten)
    @zisseki = Zisseki.load(serial, siten)
    @yosan   = Yosan.load(serial, siten)
    @keiri   = Keiripl.load(serial, siten)
    @czennen  = Zisseki.load_cumulative(Month.last_year(serial), siten)
    @czisseki = Zisseki.load_cumulative(serial, siten)
    @cyosan   = Yosan.load_cumulative(serial, siten)
    @ckeiri   = Keiripl.load_cumulative(serial, siten)
  end

  # 実績更新
  def zedit
    load_siten(params)
    @zisseki = Zisseki.load(@month, @siten)
    y, m = Month.yyyy_mm(@serial)
    @title = "[更新] #{y}年度#{m}月度実績: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def zupdate
    pr = {:id => params[:zisseki][:siten_id], :month => params[:zisseki][:month]}
    load_siten(pr)
    @zisseki = Zisseki.load(@serial, @siten)
    respond_to do |format|
      if @zisseki.update_attributes(params[:zisseki])
        flash[:notice] = "実績が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @serial) }
      else
        format.html { render :action => "zedit" }
      end
    end
  end

  # 予算更新
  def yedit
    load_siten(params)
    @yosan = Yosan.load(@serial, @siten)
    y, m = Month.yyyy_mm(@serial)
    @title = "[更新] #{y}年度#{m}月度予算: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def yupdate
    pr = {:id => params[:yosan][:siten_id], :month => params[:yosan][:month]}
    load_siten(pr)
    @yosan = Yosan.load(@serial, @siten)
    respond_to do |format|
      if @yosan.update_attributes(params[:yosan])
        flash[:notice] = "予算が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @serial) }
      else
        format.html { render :action => "yedit" }
      end
    end
  end

  # 経理更新
  def kedit
    load_siten(params)
    @keiri = Keiripl.load(@serial, @siten)
    y, m = Month.yyyy_mm(@serial)
    @title = "[更新] #{y}年度#{m}月度経理: #{@siten.dispname}"

    respond_to do |format|
      format.html
    end
  end

  def kupdate
    pr = {:id => params[:keiripl][:siten_id], :month => params[:keiripl][:month]}
    load_siten(pr)
    @keiri = Keiripl.load(@serial, @siten)
    respond_to do |format|
      if @keiri.update_attributes(params[:keiripl])
        flash[:notice] = "予算が更新されました"
        format.html { redirect_to(:action => 'monthly', :id => @siten.id,
                                  :month => @serial) }
      else
        format.html { render :action => "kedit" }
      end
    end
  end

:private

  def load_siten(params)
    @siten = Siten.find(params[:id])
    @serial = params[:month].to_i if params[:month] != nil
    @year = params[:year].to_i if params[:year] != nil
  end
end
