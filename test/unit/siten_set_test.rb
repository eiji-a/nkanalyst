# -*- coding: utf-8 -*-
require 'test_helper'

class SitenSetTest < ActiveSupport::TestCase
  def puts_errors(item)
    item.errors.each do |e, i|
      puts "ERROR: #{e} #{i}"
    end
  end

  test "initialize" do
    set1 = SitenSet.new({:name => 'abc', :startmonth => 201111})
    assert_equal set1.save, true

    # 名前なし
    set2 = SitenSet.new({:startmonth => 201111})
    st = set2.valid?
    #puts_errors(set2)
    assert_equal st, false

    # 開始月なし
    set2 = SitenSet.new({:name => 'abc'})
    st = set2.valid?
    # puts_errors(set2)
    assert_equal st, false

    # 月がおかしい
    set2.startmonth = 'abc'
    st = set2.valid?
    #puts_errors(set2)
    assert_equal st, false

    set2.startmonth = 123456
    st = set2.valid?
    #puts_errors(set2)
    assert_equal st, false

    # 既に同名/同月のsetあり
    set3 = SitenSet.new({:name => 'abc', :startmonth => 201112})
    st = set3.valid?
    #puts_errors(set3)
    assert_equal st, false

    set3.name = 'def'
    set3.startmonth = 201111
    st = set3.valid?
    #puts_errors(set3)
    assert_equal st, false
  end

  test "summarized" do
    st1 = Siten.new({:name => 's1', :dispname => 's1', :summary_flag => false})
    st2 = Siten.new({:name => 's2', :dispname => 's2', :summary_flag => false})
    st3 = Siten.new({:name => 's3', :dispname => 's3', :summary_flag => false})
    st4 = Siten.new({:name => 's5', :dispname => 's5', :summary_flag => false})
    st5 = Siten.new({:name => 's7', :dispname => 's7', :summary_flag => false})
    st6 = Siten.new({:name => 's8', :dispname => 's8', :summary_flag => false})
    tt1 = Siten.new({:name => 's4', :dispname => 's4', :summary_flag => true})
    tt2 = Siten.new({:name => 's6', :dispname => 's6', :summary_flag => true})
    tt3 = Siten.new({:name => 's9', :dispname => 's9', :summary_flag => true})
    st1.save
    st2.save
    st3.save
    st4.save
    st5.save
    st6.save
    tt1.save
    tt2.save
    tt3.save
    set1 = SitenSet.new({:name => '201012-', :startmonth => 201012})
    set2 = SitenSet.new({:name => '201107-', :startmonth => 201107})
    set1.save
    set2.save
    dt1 = SitenSetDetail.new({:sequence => 101})
    dt2 = SitenSetDetail.new({:sequence => 102})
    dt3 = SitenSetDetail.new({:sequence => 103})
    dt4 = SitenSetDetail.new({:sequence => 199, :range_start => 100, :range_end => 149})
    dt5 = SitenSetDetail.new({:sequence => 201})
    dt6 = SitenSetDetail.new({:sequence => 999, :range_start => 100, :range_end => 949})

    dt7 = SitenSetDetail.new({:sequence => 101})
    dt8 = SitenSetDetail.new({:sequence => 102})
    dt9 = SitenSetDetail.new({:sequence => 199, :range_start => 100, :range_end => 199})
    dt10 = SitenSetDetail.new({:sequence => 201})
    dt11 = SitenSetDetail.new({:sequence => 202})
    dt12 = SitenSetDetail.new({:sequence => 299, :range_start => 200, :range_end => 299})
    dt13 = SitenSetDetail.new({:sequence => 999, :range_start => 100, :range_end => 999})

    dt1.siten = st1
    dt2.siten = st2
    dt3.siten = st3
    dt4.siten = tt1
    dt5.siten = st4
    dt6.siten = tt2

    dt7.siten = st1
    dt8.siten = st2
    dt9.siten = tt1
    dt10.siten = st5
    dt11.siten = st6
    dt12.siten = tt3
    dt13.siten = tt2

    set1.details << dt1
    set1.details << dt2
    set1.details << dt3
    set1.details << dt4
    set1.details << dt5
    set1.details << dt6

    set2.details << dt7
    set2.details << dt8
    set2.details << dt9
    set2.details << dt10
    set2.details << dt11
    set2.details << dt12
    set2.details << dt13
    set1.save
    set2.save

    assert_equal dt1.save, true
    assert_equal dt2.save, true
    assert_equal dt3.save, true
    assert_equal dt4.save, true
    assert_equal dt5.save, true
    assert_equal dt6.save, true
    assert_equal dt7.save, true
    assert_equal dt8.save, true
    assert_equal dt9.save, true
    assert_equal dt10.save, true
    assert_equal dt11.save, true
    assert_equal dt12.save, true
    assert_equal dt13.save, true
    
    mon1 = Month.load(201102)
    set = SitenSet.get_range(mon1, tt1)
    assert_equal set.id, set1.id
    assert_equal set.range_start, 100
    assert_equal set.range_end, 149

    mon2 = Month.load(201112)
    set = SitenSet.get_range(mon2, tt3)
    assert_equal set.id, set2.id
    assert_equal set.range_start, 200
    assert_equal set.range_end, 299

    sitens = SitenSet.summarized_by(mon2, tt2)
    assert_equal sitens.size, 4
    assert_equal sitens[0].id, st1.id
    assert_equal sitens[1].id, st2.id
    assert_equal sitens[2].id, st5.id
    assert_equal sitens[3].id, st6.id

    sitens = SitenSet.summarized_by(mon1, tt1)
    assert_equal sitens.size, 3
    assert_equal sitens[0].id, st1.id
    assert_equal sitens[1].id, st2.id
    assert_equal sitens[2].id, st3.id

  end
end
