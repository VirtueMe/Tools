def readhash
  hash = {}
  File.open('BRUPACK.csv', 'r') do |f|
    while (line = f.gets)
      array = line.split(';')
      hash[array[2].strip.downcase] = array[1]
    end
  end
  hash
end
 
    
