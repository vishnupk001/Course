# Using the users dictionary, create a Python function named login that accepts username and password as keyword-only arguments.

# Define the function using the following syntax:

# def login(*, username, password):
#     # Write your logic here
# The function should:

# Verify that the username exists in the users dictionary.
# Verify that the password matches.
# Return True if the user's password has not expired.
# Otherwise, return False.
# Function Template

# def login(*, username, password):
#     # Write your logic here
# Clue

# Create a function named login.
# Use * to make username and password keyword-only arguments.
# Check whether the username exists in the users dictionary.
# Compare the given password with the stored password.
# If the password matches and the expired field is False, return True.
# Otherwise, return False.

users = {
    "alice": {
        "password": "alice123",
        "expired": False
    },
    "bob": {
        "password": "bob@123",
        "expired": True
    },
    "charlie": {
        "password": "charlie123",
        "expired": False
    },
    "david": {
        "password": "david@123",
        "expired": True
    },
    "emma": {
        "password": "emma123",
        "expired": False
    }
}


def login(*, username, password):

  if username in users and users[username]['password'] == password and users[username]['expired'] == False:

    return True 
  
  return False

print(login(username="alice", password="alice123"))
print(login(username="bob", password="bob@123"))
print(login(username="alice", password="wrongpass"))

        
      