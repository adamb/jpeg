# FF D8 start of image
# FF D9 end of image
# FFD0 - FFD9 and FF01 are not followed by length

open('bad.jpg', 'rb') do |io| 
  io.each_byte do |b| 
#    puts b.to_s(16)   
    puts "valid header" if b == 0xd8
    case b
    when b == 0xd8 
      puts "valid header"
  end
end

