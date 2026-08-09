fObj = open('file.txt','r')

lc = 0

for lines in fObj:
  
  lc += 1

print(f'Total No of Lines : {lc}')