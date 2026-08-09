# Create a Python script that prints all file paths that end with '.conf' from the 'config_files' list. Input config_files = [ "/etc/ssh/sshd_config", "/etc/nginx/nginx.conf", "/etc/httpd/httpd.conf", "/etc/fstab", "/etc/hosts", "/etc/resolv.conf", "/etc/sysctl.conf", "/etc/passwd", "/etc/docker/daemon.json", "/etc/kubernetes/admin.conf", "/etc/containerd/config.toml", "/etc/mysql/my.cnf", "/etc/chrony/chrony.conf", "/etc/redis/redis.conf", "/etc/systemd/system.conf" ] Clue * Use a `for` loop to iterate through the list. * Use the `endswith()` string method to check whether a file path ends with `.conf`. * Print only the matching file paths.


config_files = [ "/etc/ssh/sshd_config", "/etc/nginx/nginx.conf", "/etc/httpd/httpd.conf", "/etc/fstab", "/etc/hosts", "/etc/resolv.conf", "/etc/sysctl.conf", "/etc/passwd", "/etc/docker/daemon.json", "/etc/kubernetes/admin.conf", "/etc/containerd/config.toml", "/etc/mysql/my.cnf", "/etc/chrony/chrony.conf", "/etc/redis/redis.conf", "/etc/systemd/system.conf" ]


for filepath in config_files:
  
  if filepath.endswith('.conf'):
    
    print(filepath)
    