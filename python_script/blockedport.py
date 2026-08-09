#3.Create a Python script that checks whether any port number in the ports list is present in the blocked_ports list. 
#If a blocked port is found, set the blocked_port_detected variable to True. 
#Finally, print the value of blocked_port_detected.

#Create an empty list called ports.
#Read the paragraph and extract all port numbers.
#Add each port number to a list called ports_detected , making sure duplicate port numbers are not added.
#Create a variable named blocked_port_detected and initialize it to False.
#Use a for loop to iterate through the ports_detected list.
#Use the in operator to check whether the current port exists in the blocked_ports list.
#If a blocked port is found, set blocked_port_detected to True.
#After the loop finishes, print the value of blocked_port_detected.

msg = "TCP/IP is the standard communication protocol suite used by computers to exchange data over networks and the Internet. TCP stands for Transmission Control Protocol and provides reliable communication by ensuring that data is delivered correctly and in the proper order. IP stands for Internet Protocol and is responsible for addressing and routing packets between devices across different networks. Web servers commonly use port 80 for HTTP and port 443 for HTTPS to provide secure web communication. Secure Shell uses port 22 to allow encrypted remote access to Linux and UNIX systems. File Transfer Protocol typically uses port 21 for transferring files between computers. Domain Name System servers usually listen on port 53 to translate domain names into IP addresses. Many websites redirect traffic from port 80 to port 443 to provide secure communication. MySQL database servers generally use port 3306 , while DNS continues to use port 53 for name resolution. Understanding TCP/IP and well-known port numbers such as 22 , 21 , 25 , and 3306 helps network administrators troubleshoot connectivity issues and configure network services correctly."

ports = []
blocked_ports = ['2049', '67']

msg = str(msg).split()

for list in msg:
  
  if list.isdigit():
    
    if list not in ports:

      ports.append(list)

ports_detected = ports

print(ports_detected)

blocked_port_detected = False


for  in ports:
  
  if blocked_ports in ports:
        
    blocked_port_detected = True
      



