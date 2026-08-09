# Create a Python script that creates an empty list named ports. Read the paragraph above, extract all the port numbers, and append each port number to the ports list only if it is not already present. Finally, print the ports list.


msg = "TCP/IP is the standard communication protocol suite used by computers to exchange data over networks and the Internet. TCP stands for Transmission Control Protocol and provides reliable communication by ensuring that data is delivered correctly and in the proper order. IP stands for Internet Protocol and is responsible for addressing and routing packets between devices across different networks. Web servers commonly use port 80 for HTTP and port 443 for HTTPS to provide secure web communication. Secure Shell uses port 22 to allow encrypted remote access to Linux and UNIX systems. File Transfer Protocol typically uses port 21 for transferring files between computers. Domain Name System servers usually listen on port 53 to translate domain names into IP addresses. Many websites redirect traffic from port 80 to port 443 to provide secure communication. MySQL database servers generally use port 3306 , while DNS continues to use port 53 for name resolution. Understanding TCP/IP and well-known port numbers such as 22 , 21 , 25 , and 3306 helps network administrators troubleshoot connectivity issues and configure network services correctly."


ports = []

msg = str(msg).split()

for list in msg:
  
  if list.isdigit():
    
    if list not in ports:

      ports.append(list)

print(ports)

