# -*- coding: utf-8 -*-
require 'test_helper'

class SitenSetDetailTest < ActiveSupport::TestCase
  def puts_errors(item)
    item.errors.each do |e, i|
      puts "ERROR: #{e} #{i}"
    end
  end

  test "initialize" do
    # 基礎データ
    set = SitenSet.new({:name => 'set1', :startmonth => 201101})
    assert_equal set.save, true
    siten = Siten.new({:name => 'siten1', :dispname => 'siten1',
                       :summary_flag => false})
    assert_equal siten.save, true
    siten2 = Siten.new({:name => 'sum1', :dispname => 'sum1',
                        :summary_flag => true})
    assert_equal siten2.save, true
    siten3 = Siten.new({:name => 'siten3', :dispname => 'siten3',
                        :summary_flag => false})
    assert_equal siten3.save, true

    # 最低限のデータ作成(range無くてもOK)
    dt1 = SitenSetDetail.new
    dt1.siten_set = set
    dt1.siten = siten
    dt1.sequence = 1000
    st = dt1.valid?
    assert_equal st, true

    # レンジを追加
    dt2 = SitenSetDetail.new
    dt2.siten_set = set
    dt2.siten = siten2
    dt2.sequence = 9000
    dt2.range_start = 1000
    dt2.range_end   = 2000
    assert_equal dt2.valid?, true

    # 不完全か型がおかしい場合
    dt3 = SitenSetDetail.new
    dt3.siten_set = set
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, false

    dt3.sequence = 'abc'
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, false

    dt3.sequence = 1001
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, false

    dt3.siten = siten
    st = dt3.valid?
    puts_errors(dt3)
    assert_equal st, true

    dt3.range_start = 'sdd'
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, true

    dt3.range_start = 1000
    dt3.range_end   = 'ddd'
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, true

    dt3.range_end = 1000
    st = dt3.valid?
    #puts_errors(dt3)
    assert_equal st, true
    dt3.save

    # ユニークでない場合
    dt4 = SitenSetDetail.new
    dt4.siten_set = set
    dt4.siten = siten  # 同じ支店セットに同一の支店あり
    dt4.sequence = 1002
    st = dt4.valid?
    #puts_errors(dt4)
    assert_equal st, false

    dt5 = SitenSetDetail.new
    dt5.siten_set = set
    dt5.siten = siten2
    dt5.sequence = 1001  # 同じ支店セットに同一の順序あり
    st = dt5.valid?
    #puts_errors(dt5)
    assert_equal st, false

    dt5.sequence = 1002
    st = dt5.valid?
    puts_errors(dt5)
    assert_equal st, true
    
  end
end
