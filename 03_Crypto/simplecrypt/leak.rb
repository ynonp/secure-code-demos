leak = IO.read('leak.txt').bytes
enc = IO.read('shells.enc').bytes

k = (0..8).map do |i|
  enc[i + 4] ^ enc[i + 5] ^ leak[i]
end

(4..enc.size - 2).each do |i|
  print((enc[i] ^ enc[i + 1] ^ k[(i - 4) % 8]).chr)
end

print("\n")
