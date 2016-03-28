require 'pp'

# trying to grok JPEG stuff....

# http://stackoverflow.com/questions/4585527/detect-eof-for-jpg-images
# Summarized: Read 0xFF. Read marker. Read the length specifier L and skip forward by L - 2 bytes. 
# After an SOS (0xFFDA) segment (followed by compressed data) skip forward to the first 0xFF not 
# followed by 0x00 or 0xD0-0xD8. Repeat from start until you encounter 0xFFD9.

# FF D8 start of image
# FF D9 end of image
# FFD0 - FFD9 and FF01 are not followed by length
START = 0xffd8
JPGEND = 0xffd9
# skip these markers
SKIP = [0xff00, 0xff01, 0xffd0, 0xffd1, 0xffd2, 0xffd3, 0xffd4, 0xffd5, 0xffd6, 0xffd7, 0xffd8]

open('good.jpg', 'rb') do |io| 
  while buf = io.read(2)
    d = buf.unpack('n').first

    puts "valid header" if d == START
    puts "valid end" if d == JPGEND # doesn't work
    # puts "skip" if SKIP.include? d
    if SKIP.include? d then
      puts d.to_s(16)
      next
    end
    # figure out the segment length
    b = buf.unpack('c')
    if b[0] == 0xff then
      puts "look for length"
      buf = io.read(2)
      l = buf.unpack('n').first
      puts "length #{l}"
    end
  end
end

