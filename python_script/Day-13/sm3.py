fObj = open('file.txt','r')

wc = 0

for lines in fObj:
   
   for word in lines.lower().replace(',','').replace('.','').split():

     #wc = wc + len(lines.split())

     print(word)

fObj.close()