#!/bin/bash
# Use this for your EC2 user data

# Install Apache
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create images folder (required for background image)
mkdir -p /var/www/html/images

# Get IMDSv2 Token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" || true)

# Background metadata requests
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/local-ipv4 > /tmp/local_ipv4 &
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/placement/availability-zone > /tmp/az &
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/network/interfaces/macs/ > /tmp/macid &
wait

macid=$(cat /tmp/macid)
local_ipv4=$(cat /tmp/local_ipv4)
az=$(cat /tmp/az)
vpc=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id)

# Download background image
curl -L -o /var/www/html/images/Paradise.jpg \
  "https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/Paradise.jpg"

# Build HTML Page
cat <<EOF > /var/www/html/index.html
<!doctype html>
<html lang="en" class="h-100">
<head>
<title>Welcome to Paradise</title>
<style>
  body {
    margin:0;
    font-family:Arial, Helvetica, sans-serif;
    background:url('images/Paradise.jpg') center/cover no-repeat fixed;
    color:white;
    text-shadow:0 1px 4px rgba(0,0,0,0.7);
  }
  .overlay {
    background:rgba(0,0,0,0.35);
    padding:20px;
    margin:40px auto;
    border-radius:12px;
    max-width:1200px;
  }
  h1 { text-align:center; }
  .meta { text-align:center; margin-bottom:20px; }

  .gallery {
    display:flex;
    gap:12px;
    justify-content:center;
    flex-wrap:wrap;
  }
  .card {
    flex:1 1 45%;
    min-width:250px;
    max-width:360px;
    background:rgba(255,255,255,0.07);
    border-radius:8px;
    overflow:hidden;
  }
  .card img {
    width:50%;
    height:220px;
    object-fit:cover;
  }
  .caption {
    padding:10px;
    text-align:center;
  }
</style>
</head>
<body>

<div class="overlay">
  <h1>Paradise is where hard work pays off and those who succeed can reap the reward!</h1>
  <h1>In paradise, we will be sought after because of the wealth of knowledge we have</h1>

  <br>

  <div class="gallery">
    <div class="card">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian1.gif">
      <div class="caption">Japanese</div>
    </div>
    <div class="card">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian2.gif">
      <div class="caption">Korean</div>
    </div>
    <div class="card">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian3.gif">
      <div class="caption">Chinese</div>
    </div>
  </div>
</div>

<br>
<p><b>Instance Name:</b> $(hostname -f)</p>
<p><b>Instance Private IP Address:</b> ${local_ipv4}</p>
<p><b>Availability Zone:</b> ${az}</p>
<p><b>Virtual Private Cloud (VPC):</b> ${vpc}</p>

</body>
</html>
EOF

# Clean up
rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
