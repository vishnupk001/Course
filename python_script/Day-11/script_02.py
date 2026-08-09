# Create a Python script that creates a list of lists called config_files from the given dictionary. Initialize config_files as an empty list.

# Each inner list should contain:

# The configuration file name (dictionary key)
# The file size

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

  if conf in files:
    
    file = conf
    
    size = files[conf]["size"]
    
    config_files.append([file, size])
  
print(f'config_files = {config_files}')
