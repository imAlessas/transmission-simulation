# add padding_bits to round the number to 26. Use the last 6 bits (up to 64 rapresentation) to say how many of the bits are for padding. after de-inerleaving remove padding bits.
# to know how many bits are for padding: 

padding_bits = number_of_bits_in_the_sequence % 26;
if padding_bits < 6
	padding_bits = padding_bits + 26
end

# convert padding_bits in binary and append the following number:
zeros for (padding_bits  - 6) times + padding_bits_converted