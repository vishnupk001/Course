# print the count of char without knowing what are the characters listed in list.


words = 'aaaabbbbbhhhhjjjjkkkaaa'

counter = {}

for char in words:
  
  if char not in counter:

    counter[char] = 1
  
  else:

    counter[char] += 1

print(counter)

