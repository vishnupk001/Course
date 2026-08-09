# Create a Python script that finds the configuration file with the largest size from the config_sizes dictionary.

#Use a temporary variable to keep track of the largest file size and another variable to store the corresponding file name.

config_sizes = {
    "/etc/ssh/sshd_config": 4096,
    "/etc/nginx/nginx.conf": 2048,
    "/etc/httpd/httpd.conf": 3072,
    "/etc/httpd/conf.d/ssl.conf": 2048,
    "/etc/httpd/conf.modules.d/00-mpm.conf": 1024,
    "/etc/fstab": 1024,
    "/etc/hosts": 512,
    "/etc/resolv.conf": 256,
    "/etc/docker/daemon.json": 768,
    "/etc/docker/key.json": 512,
    "/etc/docker/plugins/plugin.json": 1536,
    "/etc/kubernetes/admin.conf": 6144,
    "/etc/containerd/config.toml": 2816
}

largest_size = 0

largest_file = ""

for files in config_sizes:
  
  value = config_sizes[files]
  
  if value > largest_size:

    largest_size = value
    
    largest_file = files

print (largest_file)

