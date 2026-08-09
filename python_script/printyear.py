#  3. Create a Python program that prints the year from each date in the given list.
#Iterate through each date in the list.
#Split the date using the - character.
#The year is the last element after splitting the string.
#Print the year.

dates = [ "01-15-2021", "03-08-2022", "07-19-2023", "10-25-2024", "12-31-2025" ]

for date in dates:
  
  month = date.split('-')[-1]

  print(month)
