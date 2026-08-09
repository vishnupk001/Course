fObj = open('file.txt','r')

wc = 0

for lines in fObj:
   
   #for word in lines.split():

     wc = wc + len(lines.split())

print(f'No of Words : {wc}')

fObj.close()