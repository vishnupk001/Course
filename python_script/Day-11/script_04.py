# Create a Python script that creates a dictionary called config_sizes, where the key is the configuration file name and the value is the file size.

# Initialize config_sizes as an empty dictionary.

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

config_sizes = {}

for conf in files:
  
  value = files[conf]["size"]
  
  config_sizes[conf] = value

print(f'config_sizes = {config_sizes}')


