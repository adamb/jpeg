require 'pp'

# FF D8 start of image
# FF D9 end of image
# FFD0 - FFD9 and FF01 are not followed by length
START = 0xffd8
JPGEND = 0xffd9

open('good.jpg', 'rb') do |io| 
  while b = io.read(2)
    d = b.unpack('n').first
    puts "valid header" if d == START
    puts "valid end" if d == JPGEND
  end
end

