# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def render_footer(lead_url = "")
    version = "v Beta 0.0.01 "
    
    html = ""
    html += "<div id='footer'>"

    html << "<div class='noPrint'>"
    html << (link_to 'Home', :controller => 'public_pages', :action => 'index') <<  " | "
    html << (link_to 'How This Works', {:controller => 'public_pages', :action => 'how_this_works'}, {:rel=>'nofollow'}) << " | "
    html << (link_to 'Our Company', {:controller => 'public_pages', :action => 'our_company'}, {:rel=>'nofollow'}) << " | "
    html << (link_to 'Contact Us', {:controller => 'public_pages', :action => 'contact_us'}, {:rel=>'nofollow'}) << " | "
    html << (link_to 'Bookmark Us', {:controller => 'public_pages', :action => 'bookmark'}, {:rel=>'nofollow'}) << " | "
    html << (link_to 'Tell a Friend', {:controller => 'public_pages', :action => 'tell_a_friend'}, {:rel=>'nofollow'})  << " | "        
    html << (link_to 'Frequently Asked Questions', {:controller => 'public_pages', :action => 'frequently_asked_questions'}, {:rel=>'nofollow'}) << " | "
    html << (link_to 'Technical Support', {:controller => 'public_pages', :action => 'technical_problems'}, {:rel=>'nofollow'})  << " | "
    html << (link_to 'Site Map', :controller => 'public_pages', :action => 'sitemap') << " | "
    html << version
    #if current_user.admin?
      #html <<  (link_to 'Admin', :controller => 'admin', :action => 'index') 
    #end
    html += "<br/><br/><a href='http://www.addthis.com/bookmark.php' onclick='addthis_url   = location.href; addthis_title = document.title; 
           return addthis_click(this);' target='_blank'><img src='http://s9.addthis.com/button1-share.gif' width='125' height='16'
           border='0' alt='AddThis Social Bookmark Button' /></a> 
          <script type='text/javascript'>var addthis_pub = 'tesmar';
          </script>
          <script type='text/javascript' src='http://s9.addthis.com/js/widget.php?v=10'></script>"
    html += "<h5 align='center' style='text-align:center;'>Use of this web site constitutes acceptance of the MyDecisionHelper 
        #{ link_to 'Terms of Use', {:controller => 'public_pages', :action => 'terms_of_use'},
                                    {:popup => ['new_window', 'height=900,width=700,scrollbars=yes'], :target => '_blank', :rel=>'nofollow'} }
                                    and #{link_to 'Privacy', {:controller => 'public_pages', :action => 'privacy'}, {:rel=>'nofollow'}}.
        <br />&copy; 2004-2009 Decision Help, LLC. All Rights Reserved. Patent Pending</h5></div></div>"
    html  
  end
  
end
