require 'nokogiri'
require 'open-uri'
require "rubygems"
require "highline/import"

  ft = HighLine::ColorScheme.new do |cs|
    cs[:item] = [ :bold, :white, ]
    cs[:price] = [ :bold, :magenta,]
  end

  HighLine.color_scheme = ft

  items = Array.new
  prices = Array.new

  1.upto(7) do |page_num|
    doc = Nokogiri::HTML(open("https://www.tokopedia.com/p/handphone-tablet?page=#{page_num}"))
    items = doc.xpath("//div[contains(@class,'name')]/b").collect {|node| node.text.strip}
    prices = doc.xpath("//div[contains(@class,'product')]//span[contains(@class,'price')]").collect {|node| node.text.strip}
    prices.delete("")

    items.zip(prices).each do |title,price|
      say("<%= color(%q(#{title}), :item) %> ")
      say("<%= color(%q(#{price}), :price)%> ")
      say("\n")
    end
  end