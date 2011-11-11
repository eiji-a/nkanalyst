# -*- coding: utf-8 -*-


module Plbase

  # CONSTANTS
  RIEKI_INPUT = [['売上', 'uriage'], ['仕入', 'siire'],
                 ['支店間', 'sitenkan'], ['期首在庫', 'kisyu'],
                 ['期末在庫', 'kimatu']]
  RIEKI_VIEW  = [['在庫増減', 'zogen'], ['原価', 'genka'],
                ['粗利', 'arari']]

  HIYO_INPUT = [['給料', 'kyuryo'], ['賞与', 'syoyo'],
                ['退職', 'taisyoku'], ['法定', 'hotei'],
                ['派遣', 'haken'], ['福利', 'hukuri'],
                ['広告', 'kokoku'], ['租税', 'sozei'],
                ['賃借', 'tinsyaku'], ['手数料', 'tesu'],
                ['家賃', 'yatin'], ['償却', 'syokyaku'],
                ['燃料', 'nenryo'], ['通信', 'tusin'],
                ['光熱', 'konetu'], ['旅費', 'ryohi'],
                ['会議', 'kaigi'], ['運賃', 'untin'],
                ['修繕', 'syuzen'], ['保険', 'hoken'],
                ['倉敷', 'kurasiki'], ['保守', 'hosyu'],
                ['消耗', 'syomo'], ['事務', 'zimu'],
                ['雑費', 'zappi'], ['その他', 'sonota'],
                ['物流', 'buturyu'], ['返還', 'henkan']]
  HIYO_VIEW  = [['費用合計', 'hiyo_total']]

  EIRI_INPUT = [['雑収入', 'zatusyunyu']]
  EIRI_VIEW  = [['営業利益', 'eigyorieki']]

  KEIZYO_INPUT = [['雑収入税抜', 'zatusyunyuzeinuki'],
                  ['受取利息', 'uketoririsoku'], ['支払利息', 'siharairisoku'],
                  ['雑損失', 'zatusonsitu'], ['消費税戻', 'syohizeimodori']]
  KEIZYO_VIEW  = [['経常利益', 'keizyorieki']]

  INPUTS = RIEKI_INPUT + HIYO_INPUT + EIRI_INPUT + KEIZYO_INPUT
  ITEM_SUMS = INPUTS.map {|i| "SUM(#{i[1]}) AS #{i[1]}"}.join(", ")

  # CLASS METHODS

  def self.load(klass, serial, siten)
    pl = nil
    if siten.summary_flag == Siten::REAL
      pl = klass.find(:first,
                      :conditions => ['month = ? AND siten_id = ?',
                                      serial, siten.id])
    else
      sitens = SitenSet.summarized_by(serial, siten)
      sids = if sitens != nil then sitens.map {|s| s.id} else [] end
      table = klass.name.tableize
      sql = <<-SQL
        SELECT month,
               #{ITEM_SUMS}
          FROM #{table}
         WHERE month = :serial
           AND siten_id IN (:sitens)
      SQL
      p0 = klass.find_by_sql([sql, {:serial => serial, :sitens => sids}])
      if p0.size > 0 and p0[0].month != nil
        pl = p0[0]
        pl.id = siten.id
      end
    end

    if pl == nil
      pl = klass.new
      pl.init(serial, siten)
    end
    pl
  end

  def self.load_12months(klass, year, siten)
    ye = []
    1.upto(12) do |m|
      ye << load(klass, Month.ym2serial(year, m), siten)
    end
    return ye
  end

  def self.load_yearly(klass, year, siten)
    mstart = Month.ym2serial(year, 1)
    mend   = Month.ym2serial(year, 12)
    table = klass.name.tableize
    sql = <<-SQL
      SELECT siten_id,
             #{ITEM_SUMS}
        FROM #{table}
       WHERE siten_id = ?
         AND (month >= ? AND month <= ?)
       GROUP BY siten_id
    SQL
    pl = klass.find_by_sql([sql, siten.id, mstart, mend])[0]
    if pl == nil
      pl = klass.new
      pl.init(year, siten)
    end
    pl
  end

=begin
  def self.included(base)
    base.extend Plbase
    base.class_eval do
      alias_method_chain :load, :load2
      alias_method_chain :load_by_serial2, :load
    end
  end

  def load2(month, siten)
    val = self.class.find(:first,
                     :conditions => ['month_id = ? AND siten_id = ?',
                                     month.id, siten.id])
    if val == nil
      val = self.class.new
      val.init(month, siten)
    end
    val
  end

  def load_by_serial

  end
=end

  # INSTANCE METHODS

  def init(serial, siten)
    return unless Month.valid?(serial)

    month = serial
    siten_id = siten.id

    uriage = 0
    siire = 0
    sitenkan = 0
    kisyu = 0
    kimatu = 0

    kyuryo = 0
    syoho = 0
    taisyoku = 0
    hotei = 0
    haken = 0
    hukuri = 0
    kokoku = 0
    sozei = 0
    tinsyaku = 0
    tesu = 0
    yatin = 0
    syokyaku = 0
    nenryo = 0
    tusin = 0
    konetu = 0
    ryohi = 0
    kaigi = 0
    untin = 0
    syuzen = 0
    hoken = 0
    kurasiki = 0
    hosyu = 0
    syomo = 0
    zimu = 0
    zappi = 0
    sonota = 0
    buturyu = 0
    henkan = 0

    zatusyunyu = 0

    zatusyunyuzeinuki = 0
    uketoririsoku = 0
    siharairisoku = 0
    zatusonsitu = 0
    syohizeimodori = 0
  end

  # 計算項目

  # 
  def zogen
    @zogen = kimatu - kisyu if @zogen == nil
    return @zogen
  end

  def genka
    @genka = siire + sitenkan - zogen if @genka == nil
    return @genka
  end

  def arari
    @arari = uriage - genka if @arari == nil
    return @arari
  end

  def hiyo_total
    @hiyo_total = kyuryo + syoyo + taisyoku + hotei + haken + hukuri +
      kokoku + sozei + tinsyaku + tesu + yatin + syokyaku + nenryo +
      tusin + konetu + ryohi + kaigi + untin + syuzen + hoken +
      kurasiki + hosyu + syomo + zimu + zappi + sonota + buturyu +
      henkan if @hiyo_total == nil
    return @hiyo_total
  end

  def eigyorieki
    @eigyorieki = arari - hiyo_total + zatusyunyu if @eigyorieki == nil
    return @eigyorieki
  end

  def keizyorieki
    @keizyorieki = eigyorieki + zatusyunyuzeinuki + uketoririsoku -
      siharairisoku + syohizeimodori if @keizyorieki == nil
    return @keizyorieki
  end

end
