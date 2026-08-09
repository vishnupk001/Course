# Create a Python script that accepts a Linux file path as input and prints the total number of forward slashes (/) in the path.

FilePath = input("Enter The FilePath : ")

fslash = 0

for item in FilePath:
    
    if item == '/':
        
        fslash = fslash + 1
        
print("Sum of Forward Slash : ",fslash)

