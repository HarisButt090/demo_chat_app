module DateTimeHandler
    def convert_to_24_hour_format(time_str)
      Time.zone.strptime(time_str, "%I:%M %p")
    end
  
    def convert_to_12_hour_format(time_obj)
      (time_obj.is_a?(String)) ? Time.parse(time_obj).strftime("%I:%M %p") : time_obj.strftime("%I:%M %p")
    end
    
    def combined_date_time(date, time)
      Time.parse("#{date} #{time}")
    end
  
    def day_of_week(date)
      (date.is_a?(String)) ? Date.parse(date).strftime('%A') : date.strftime('%A')
    end
  
    def format_mm_dd_yyyy(date)
      # In specific Format -> "May 02, 2024"
      date.strftime("%B %d, %Y") 
    end
  
    def format_dd_mm_yy(date)
      # In specific Format -> "09 November 2024"
      (date.is_a? (String)) ? Date.parse(date).strftime("%A, %d %B %Y") : date.strftime("%A, %d %B %Y")
    end
  
    def calculate_fixture_time(day, time)
      day_of_week = Date::DAYNAMES.index(day.capitalize) # Find index for the given weekday
      current_date = Date.current
      target_date = current_date + ((day_of_week - current_date.wday) % 7)
      Time.zone.parse("#{target_date} #{time}")
    end
end
  