#myDict = {'alex': {'age': 25, 'salary': 4000, 'exp': 4}, 'sam': {'age': 26, 'salary': 4500, 'exp': 8}, 'kevin': {'age': 29, 'salary': 5000, 'exp': 9}, 'arun': {'age': 35, 'salary': 35000, 'exp': 7}}
'''
myDict['alex'] = {'age': 25, 'salary': 4000, 'exp': 4}
myDict['sam'] = {'age': 26, 'salary': 4500, 'exp': 8}
myDict['kevin'] = {'age': 29, 'salary': 5000, 'exp': 9}
myDict['arun'] = {'age': 35, 'salary': 35000, 'exp': 7}

print(myDict)

'''

employee_dict = {'alex':27,'sam':31,'kevin':40}

for name in employee_dict:
  
  value = employee_dict[name]

  print(name,value)