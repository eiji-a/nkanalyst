# -*- coding: utf-8 -*-
require 'test_helper'

class MonthTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "instanciate" do
    mon = Month.new
    assert_equal mon.month, nil
    assert_equal mon.serial, nil
    assert_equal mon.year, nil
    assert_equal mon.order, nil
    assert_equal mon.fix_flag, nil

    mon = Month.new(:month => 201109)
    assert_equal mon.month, 201109
    assert_equal mon.serial, nil
    assert_equal mon.valid?, true
    mon.errors.each do |at, er|
      puts "AT=#{at}, ERR=#{er}"
    end
    assert_equal mon.save, true
    assert_equal mon.month, 201109
    assert_equal mon.serial, 24140
    assert_equal mon.year, 2011
    assert_equal mon.order, 3
    assert_equal mon.fix_flag, Month::UNFIXED
    assert_equal mon.yyyy, 2011
    assert_equal mon.mm, 9

    mon = Month.new(:month => 201104)
    assert_equal mon.month, 201104
    assert_equal mon.serial, nil
    assert_equal mon.valid?, true
    mon.errors.each do |at, er|
      puts "AT=#{at}, ERR=#{er}"
    end
    assert_equal mon.save, true
    assert_equal mon.month, 201104
    assert_equal mon.serial, 24135
    assert_equal mon.year, 2010
    assert_equal mon.order, 10
    assert_equal mon.fix_flag, Month::UNFIXED
    assert_equal mon.yyyy, 2011
    assert_equal mon.mm, 4

    mon = Month.new(:month => 'abc')
    assert_raise(ArgumentError) {
      assert_equal mon.save, true
    }
  end

  test "save" do
    mon = Month.new(:month => 201109)
    assert_nothing_raised(StandardError) {
      assert_equal mon.save, true
    }
    mon2 = Month.find_by_month(201109)
    assert_equal mon2.month, 201109
    mon3 = Month.new(:month => 201110)
    assert_nothing_raised(StandardError) {
      assert_equal mon3.save, true
    }
    mon2 = Month.find_all_by_month(201110)
    assert_equal mon2.size, 1

    # 同じ月が登録できてはいけない！
    mon4 = Month.new(:month => 201109)
    assert_raise(Test::Unit::AssertionFailedError) {
      assert_equal mon4.save, true
    }
    mon2 = Month.find_all_by_month(201109)
    assert_equal mon2.size, 1

    # 月が未設定だと保存できない！
    mon5 = Month.new
    assert_raise(ArgumentError) {
      assert_equal mon5.save, false
    }
    
  end

  test "convert methods" do
    s = Month.month2serial(201109)
    assert_equal s, 24140
    o = Month.month2order(201109)
    assert_equal o, 3
    o = Month.month2order(201107)
    assert_equal o, 1
    o = Month.month2order(201106)
    assert_equal o, 12
    y = Month.month2year(201109)
    assert_equal y, 2011
    assert_raise(ArgumentError) {s = Month.month2serial(100020)}
    assert_raise(ArgumentError) {s = Month.month2serial(201100)}
    assert_raise(ArgumentError) {s = Month.month2serial(201113)}
    assert_raise(ArgumentError) {s = Month.month2serial(199912)}
    assert_raise(ArgumentError) {s = Month.month2serial(199913)}
    assert_raise(ArgumentError) {s = Month.month2serial(200000)}
    assert_raise(ArgumentError) {s = Month.month2serial(210101)}

    assert_nothing_raised(ArgumentError) {s = Month.month2serial(200001)}
    assert_nothing_raised(ArgumentError) {s = Month.month2serial(210012)}

  end

  test "load" do
    mon = Month.new(:month => 201108)
    mon.save
    assert_equal mon.month, 201108
    mon2 = Month.load(201108)
    assert_equal mon2.month, 201108
    
    mon3 = Month.load(201107)
    assert_equal mon3.month, 201107
    mon4 = Month.find_by_month(201107)

    assert_raise(ArgumentError) {mon5 = Month.load(180001)}
  end
end
