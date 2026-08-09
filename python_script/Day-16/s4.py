# Using the instances list, create a Python function named has_instance that accepts an instance type and a RAM size in gigabytes.

# The ram parameter should have a default value of 4.

# The function should return True if an instance with the given type and RAM exists. Otherwise, return False.

instances = [
    {
        "type": "t3.micro",
        "hostname": "web-01",
        "ram": 1,
        "disk": 20
    },
    {
        "type": "t3.micro",
        "hostname": "web-02",
        "ram": 1,
        "disk": 20
    },
    {
        "type": "t3.small",
        "hostname": "api-01",
        "ram": 2,
        "disk": 40
    },
    {
        "type": "t3.small",
        "hostname": "api-02",
        "ram": 2,
        "disk": 40
    },
    {
        "type": "t3.medium",
        "hostname": "db-01",
        "ram": 4,
        "disk": 80
    },
    {
        "type": "t3.medium",
        "hostname": "worker-01",
        "ram": 4,
        "disk": 80
    },
    {
        "type": "t3.medium",
        "hostname": "worker-02",
        "ram": 4,
        "disk": 80
    }
]

def has_instance(instance_type, ram=4):
  
  for instance in instances:

    if instance["type"] == instance_type:

      if instance["ram"] == ram:

        result = True

      else:
         
        result = False
  
  return result

print(has_instance("t3.medium"))
print(has_instance("t3.small"))
print(has_instance("t3.small", 2))