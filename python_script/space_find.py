# Create a Python script that checks whether the given string contains any spaces. If the string contains a space, print "Password Rejected". Otherwise, print "Password Accepted". input: hello world output: Password Rejected input: MyPassword123 output: Password Accepted input: pass word123 output: Password Rejected

password = input("Enter Your Password : ")

space_count = 0



for item in password:
    
      if item == " ":
        
         space_count = space_count + 1

if space_count > 0:
    
    print("Password Rejected")
    
else:
    
    print("Password Accepted")

   


         


    
    
    
    


        
        
    
    