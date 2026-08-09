# Using the services dictionary, create a Python function named is_service_running that accepts a service name as a parameter and a default argument named expected_status with the value "running".

# Define the function using the following syntax:

# def is_service_running(service_name, expected_status="running"):
#     # Write your logic here
# The function should:

# Check whether the service exists in the services dictionary.
# Compare the service's current status with expected_status.
# Return True if both statuses match.
# Otherwise, return False.

services = {
    "nginx": "running",
    "httpd": "stopped",
    "docker": "running",
    "sshd": "running",
    "named": "stopped"
}

def is_service_running(service_name, expected_status="running"):
  
  for service in services:

    if service_name in service:

      values = services[service] 
      
      if values == expected_status:

        result = True

      else:

        result = False

  return result

print(is_service_running("nginx"))
print(is_service_running("httpd"))
print(is_service_running("httpd", "stopped"))

