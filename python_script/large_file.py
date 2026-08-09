# 5. Create a Python program that prints the file path from the config_files list where the 
#file size is greater than or equal to 2046 bytes.

config_files = [ ["/etc/ssh/sshd_config", 4096], ["/etc/fstab", 2048], ["/etc/hosts", 512], ["/etc/resolv.conf", 1024], ["/etc/passwd", 3072], ["/etc/group", 2048], ["/etc/crontab", 1024], ["/etc/sysctl.conf", 2560], ["/etc/profile", 3584], ["/etc/environment", 768], ["/etc/hostname", 256], ["/etc/network/interfaces", 1536], ["/etc/nsswitch.conf", 2304], ["/etc/logrotate.conf", 1280], ["/etc/sudoers", 1792] ]

for files in config_files:
  
  if files[1] >= 2046:
    
    print(files[0])