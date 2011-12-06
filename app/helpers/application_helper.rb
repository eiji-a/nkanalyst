# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nknumber(value)
    pm = if value >= 0 then "plus" else "minus" end
    num = number_to_currency(value, :precision => 0, :unit => '')
    "<span class=\"num_#{pm}\">#{num}</span>"
  end

  def nkrate(v1, v2)
    if v2 == 0
      "-"
    else
      sprintf("%.1f", v1 * 100.0 / v2)
    end
  end
end
