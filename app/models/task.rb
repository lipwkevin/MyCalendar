class Task < ApplicationRecord
   attr_accessor :everyday
  belongs_to :schedule

  def get_color
    t = time.hour
    if (MORNING_START..NOON_START).cover? t
      return "morning"
    elsif (NOON_START..NIGHT_START).cover? t
      return "noon"
    else
      return 'night'
    end
  end
end
