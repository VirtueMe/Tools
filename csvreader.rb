#!/usr/bin/ruby

require 'csv'

CSV.foreach("packages.txt", { :headers => true }) do |row|
   File.rename("results/GBU#{row['Item']}", "results/GBU#{row['Package']}") if File.exists?("results/GBU#{row['Item']}")
end

