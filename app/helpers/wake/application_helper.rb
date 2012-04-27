module Wake
  module ApplicationHelper
    
    def ico(x, color=nil)
      raw "<span class='iconic #{x} #{color}'></span>"
    end
    
  end
end
