#!/usr/bin/ruby

require 'net/http'

def download picture, filename
  Net::HTTP.start("www.earlymoments.com") do |http|
    image = open(filename, "w")

    begin
      http.request_get(picture) do |resp|
        resp.read_body do |segment|
            image.write(segment)
        end
      end
    ensure
      image.close()
    end
  end
end
  
