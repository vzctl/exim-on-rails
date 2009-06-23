module ApplicationHelper
  def separate_links (links)
    menubar = []
    links.each{|link| menubar << link_to(link[0],link[1])}
    menubar.sort.reverse.join("&nbsp;|&nbsp;")
  end

  def header_title
    @title ? " / <small>#{@title}</small>" : ''
  end
end
