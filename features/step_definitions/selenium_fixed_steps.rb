module Webrat
  class SeleniumSession
    
    ["click_link", "click_button"].each do |method|
      class_eval <<-EOF
        alias :old_#{method} :#{method}
        def #{method}(*args)
          old_#{method}(args)
          warn "waiting for the page to load..."
          selenium.wait_for_page_to_load
        end
      EOF
    end

  end
  
end