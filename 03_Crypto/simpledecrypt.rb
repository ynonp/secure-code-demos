filename = ARGV.shift
leak = "Hello\n\nThis is"
enc = IO.read(filename).bytes
key = []

(0..leak.size - 1).each do |i|
  key << (leak[i].ord ^ enc[i + 4] ^ enc[i + 5]).to_s(16)
end

puts key[5..12].reverse.join(' ')
