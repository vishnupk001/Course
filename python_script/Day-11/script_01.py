# Create a Python script that appends the configuration file names whose group is apache to a list called config_files. Initialize the config_files list as an empty list.

# Clue

# Use a for loop to iterate through the dictionary.
# Access the nested dictionary using the file path as the key.
# Check whether the value of the "group" key is "apache".
# If it is, append the file path to the config_files list. 


files = {
    "/etc/ssh/sshd_config": {
        "size": 4096,
        "owner": "root",
        "group": "root"
    },
    "/etc/nginx/nginx.conf": {
        "size": 2048,
        "owner": "root",
        "group": "root"
    },
    "/etc/httpd/httpd.conf": {
        "size": 3072,
        "owner": "apache",
        "group": "apache"
    },
    "/etc/httpd/conf.d/ssl.conf": {
        "size": 2048,
        "owner": "apache",
        "group": "apache"
    },
    "/etc/httpd/conf.modules.d/00-mpm.conf": {
        "size": 1024,
        "owner": "apache",
        "group": "apache"
    },
    "/etc/fstab": {
        "size": 1024,
        "owner": "root",
        "group": "root"
    },
    "/etc/hosts": {
        "size": 512,
        "owner": "root",
        "group": "root"
    },
    "/etc/resolv.conf": {
        "size": 256,
        "owner": "systemd-resolve",
        "group": "systemd-resolve"
    },
    "/etc/docker/daemon.json": {
        "size": 768,
        "owner": "root",
        "group": "docker"
    },
    "/etc/docker/key.json": {
        "size": 512,
        "owner": "root",
        "group": "docker"
    },
    "/etc/docker/plugins/plugin.json": {
        "size": 1536,
        "owner": "root",
        "group": "docker"
    },
    "/etc/kubernetes/admin.conf": {
        "size": 6144,
        "owner": "root",
        "group": "root"
    },
    "/etc/containerd/config.toml": {
        "size": 2816,
        "owner": "root",
        "group": "root"
    }
}

config_files = []

for conf in files:
  
  if files[conf]["group"] == "apache":
    
    config_files.append(conf)
   
print(config_files)
