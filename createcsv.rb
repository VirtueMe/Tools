#!/usr/bin/ruby

require_relative 'createhash'
require_relative 'template'
require 'nokogiri'

filename = "books"
filename = ARGV[1] if ARGV.length > 1
outputfile = "#{filename}.csv"
path = "."
path = ARGV[0].gsub("\\", "/") if ARGV.length > 0

filesargument = "#{path}/*.xml"
#puts filesargument
files = Dir[filesargument];

hash = readhash

if files.count > 0
  File.open(outputfile, 'w') do |f|
    f.puts "productid;name;articleid;date created;text;tie-in;filename"
    files.each do |name|
      doc = Nokogiri::XML(File.open(name), "UTF-8")
	
      product = doc.xpath("//product")
      
      t = Nokogiri::HTML(product.css(((product.css("ingress").inner_text.empty?) ? "text" : "ingress")).inner_text, "UTF-8").text
      text = t.split(/\r?\n/)
   
      if text.length > 2
	i = text.index { |e| e.start_with?("Tie-") }
	if i
	  text = text[(i-1),2]
	  text[0].gsub!(";", ".")
	else
          puts text
	end
      else
	if text[1].start_with?("Tie-") == false
	  text = Array.new(2)
          pos = t.index("Tie-")
	
	  if pos > -1
	    text[0] = t[0, pos]
	    text[1] = t[pos, t.length]
	  else
	    puts "error: missing Tie-in Activity"
          end
	else
	end
      end
      
      puts("error:" + text[1]) if text[0].include?("\n") or text[0].include?("\r")

      title = product.css("title").inner_text
      lookuptitle = title.split('|')[0].downcase.strip
      key = ''

      key = '"' + hash[lookuptitle] + '"' if hash.has_key?(lookuptitle)

      IO.write("results/#{lookuptitle.gsub('?','')}.xml", createxml(key.gsub('"', ''), lookuptitle, ((text.length>0)?text[0]:t).chomp, ((text.length> 1)?text[1]:""),  product.css("url").inner_text, product.css("created").inner_text)) unless key.empty?

      f.puts(key + ';' + title + ";http://www.earlymoments.com" + product.css("url").inner_text + ";" + product.css("created").inner_text + ";" + ((text.length>0)?text[0]:t).chomp + ";" + ((text.length> 1)?text[1]:"") + ";" + name.force_encoding("UTF-8") )
    end
  end
else
  puts "No files found"
end
