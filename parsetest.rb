require 'nokogiri'

require 'open-uri'

doc = Nokogiri::HTML(open("http://whatis.techtarget.com"))
links = []
doc.css('div#header div#headerSubnav div#headerSubnavCompress div.headerBrowseAlpha ul.listTypeAlpha li a').each do |node|
	links << node.text
end
result = {}
links.each do |l|
	doc = Nokogiri::HTML(open("http://whatis.techtarget.com/definitions/" + l))
	
	count = doc.css('div#content div#contentCompress div#article div#articleBody div.childTopicColumns ul li div.childCol1 ul li').count
	count.times do |t|
		if t == 0
			doc = Nokogiri::HTML(open("http://whatis.techtarget.com/definitions/" + l))
		else
			doc = Nokogiri::HTML(open("http://whatis.techtarget.com/definitions/" + l + "/page/" + (t + 1).to_s))
		end
		puts "processing " + l
		doc.css('div#content div#contentCompress div#article div#articleBody div.childTopicColumns ul li div.childCol2 ul li a').each do |el|		
			result[el.text] = el["href"]
		end
	end
end

File.open("D:/total.txt","w:UTF-8") do |f|
	result.each do |k,v|
		puts "writing to file: " + k
		f.puts(k + "*" + v)
	end
end