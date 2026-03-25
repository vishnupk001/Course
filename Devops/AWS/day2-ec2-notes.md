# Day 2 – Hosting a Website on EC2

## Firewall Basics
- **Netfilter** – Core firewall framework in Linux  
- Tools built on Netfilter:
  - iptables
  - CSF (ConfigServer Firewall)
- **Security Group** = Firewall in AWS (controls inbound & outbound traffic)

---

## Step 1: Create EC2 Instance (Web Server)
- Select **AMI (Amazon Machine Image)**
- Choose **Instance Type**
- Create/select **Key Pair**
- Configure **Network Settings**
  - Attach **Security Group** (allow HTTP/SSH)
- Configure **Storage**
  - Default: **8 GB**
- Add **Tag**
  - Example: Name = WebServer

---

## Step 2: Connect to EC2
Use SSH with private key:
```bash
ssh -i your-key.pem ec2-user@your-public-ip
```

---

## Step 3: Install Web Server (Apache / httpd)

### Install package
```bash
sudo yum install httpd -y
```

### Start service
```bash
sudo systemctl start httpd
```

### Enable service on boot
```bash
sudo systemctl enable httpd
```

---

## Step 4: Create Website Content
Navigate to web directory:
```bash
cd /var/www/html
```

Create index file:
```bash
sudo nano index.html
```

Add content:
```html
<h1>Welcome to My Website</h1>
```

---

## Step 5: Test Website
- Open browser
- Enter **Public DNS / Public IP of EC2**
- Your website should load

---

## Key Notes
- Ensure **Security Group allows port 80 (HTTP)**
- Use **port 22 (SSH)** for remote access
- Public DNS is used to access the website
