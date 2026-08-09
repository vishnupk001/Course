fObj = open('file.txt','r')

cc = 0

for lines in fObj:
  
  cc += len(lines)

print(f'Total No of Lines : {cc}')

fObj.close()