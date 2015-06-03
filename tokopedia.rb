require 'nokogiri'
require 'open-uri'
require "rubygems"
require "highline/import"

  ft = HighLine::ColorScheme.new do |cs|
    cs[:colorcat] = [ :bold, :magenta,]
  end
  HighLine.color_scheme = ft

  say("\nTokopedia Scrapper Tools v1.0")
  say("Please choose menu : \n")

  loop do 
  choose do |menu| 
    menu.index = :letter
    menu.index_suffix = ") "


    menu.choice :category do 
    categories = Array.new
    doc = Nokogiri::HTML(open("https://www.tokopedia.com/"))
    categories = doc.xpath("//option[contains(@class,'ml-10')]").collect {|node| node.text.strip}

      categories.each do |category|
        puts category+" "
      end

    say("<%= color('Please insert name of product', :colorcat) %>")
    
    end

      menu.choice :hotlist do 
        doc = Nokogiri::HTML(open("https://www.tokopedia.com/hot"))
        hotlist = Array.new
        hotlist_price = Array.new
        hotlist = doc.xpath("//div[contains(@class,'mt-5 fs-12 ellipsis')]").collect {|node| node.text.strip}
        hotlist_price = doc.xpath("//div[contains(@id,'hot-product-list')]//span").collect { |node| node.text.strip}

        hotlist.zip(hotlist_price).each do |name,price|
            puts name+" "+price
        end
      end
      menu.choice(:quit, "Exit Tools ") { exit }
      say("\nThank you using this tools")
    end
  end