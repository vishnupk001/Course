# 3. Create a Python script that accepts a file path and checks whether it ends with the .conf extension. If the file path ends with .conf, print Valid configuration file; otherwise, print Invalid configuration file. Input: /etc/httpd/httpd.conf Output: Valid configuration file ---------------------- Input: /etc/nginx/nginx.conf Output: Valid configuration file ---------------------- Input: /home/user/readme.txt Output: Invalid configuration file ---------------------- Input: /opt/app/config.json Output: Invalid configuration file

FilePath = input("Enter A File Path : ")

if FilePath.endswith(".conf"):
    
    print("Valid configuration file")
    
else:
    
    print("Invalid configuration file")