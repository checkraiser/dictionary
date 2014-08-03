

# encoding: UTF-8
require 'open-uri'
require 'nokogiri'
require 'google_translate'
require 'sqlite3'

db = SQLite3::Database.open "ja7.db"
id = 1
errors = []
File.readlines('D:/total.txt').each do |line|

	  
	parts = line.split('*')
	term = parts[0]
	url = parts[1]
	
	
	doc = Nokogiri::HTML(open(url))
	if doc.css('#articleBody')
		t = ""
		doc.css('#articleBody p').each do |node|
			t += node.text
		end
	else
		t = doc.css('#content-center').text
	end
	if t
		t1 = t.gsub(/(?<!\n)\n(?!\n)/, ' ').gsub(/(?<!\r)\r(?!\r)/, ' ')		
		trans = GoogleTranslate.new	
		puts "term: " + term
		x = trans.translate(:en, :ja, term+'.')
		y = trans.translate(:en, :ja, t1)
		
		puts(x[0][0][1] + ":" + x[0][0][0])
		meaning = "<div class='origin_meaning'>"+x[0][0][0] +"</div><br/>"
		y[0].each do |yi|
			meaning +=  
				"<div class='english_sentence'>"+yi[1]+"</div><br/>" +
				"<div class='translated_sentence'>" +yi[0]+"</div><br/>" +
				"<div class='additional_info'>"+yi[2]+"</div><br/>"
		end
		id += 1
		db.execute("INSERT INTO japanese (id, origin, meaning) 
		VALUES (?, ?, ?)", [id, term, meaning])
		puts "executed term"
			#f.puts(yi[1])
			#f.puts(yi[0])
			#f.puts(yi[2])
		
	else
		errors << url
	end
	
	
end
File.open("D:/errors.txt","w:utf-8") {|f| f.puts(errors)}
#puts x[0][0].length
#puts x