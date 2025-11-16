#!/bin/bash
# Tropical gallery webpage — fully self-contained, no uploads needed.

set -euo pipefail

yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Images folder
mkdir -p /var/www/html/images

# --- Download images automatically ---
# Tropical beach background
curl -L -o /var/www/html/images/tropical-bg.jpg \
  "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1600&q=85&auto=format&fit=crop"

# Photo 1
#curl -L -o /var/www/html/images/photo1.jpg \
  "https://images.unsplash.com/photo-1493558103817-58b2924bce98?w=1200&q=85&auto=format&fit=crop"

# Photo 2
#curl -L -o /var/www/html/images/photo2.jpg \
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&q=85&auto=format&fit=crop'

# Photo 3
#curl -L -o /var/www/html/images/photo3.jpg \
  "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&q=85&auto=format&fit=crop"

chmod -R 755 /var/www/html/images

# Instance metadata
TOKEN=$(curl -sf -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 300" || true)

if [ -n "$TOKEN" ]; then
  local_ipv4=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
    http://169.254.169.254/latest/meta-data/local-ipv4 || echo "unknown")
  az=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
    http://169.254.169.254/latest/meta-data/placement/availability-zone || echo "unknown")
  macid=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
    http://169.254.169.254/latest/meta-data/network/interfaces/macs/ || echo "")
  if [ -n "$macid" ]; then
    vpc=$(curl -s -H "X-aws-ec2-metadata-token: $TOKEN" \
      http://169.254.169.254/latest/meta-data/network/interfaces/macs/${macid}/vpc-id || echo "unknown")
  else
    vpc="unknown"
  fi
else
  local_ipv4="unknown"
  az="unknown"
  vpc="unknown"
fi

hostname=$(hostname -f 2>/dev/null || echo "unknown")

# -------- HTML file --------
cat > /var/www/html/index.html <<HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Tropical Gallery</title>
<style>
  body {
    margin:0;
    font-family:Arial, Helvetica, sans-serif;
    background:url('images/tropical-bg.jpg') center/cover no-repeat fixed;
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
    flex:1 1 30%;
    min-width:250px;
    max-width:360px;
    background:rgba(255,255,255,0.07);
    border-radius:8px;
    overflow:hidden;
  }
  .card img {
    width:100%;
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
  <h1>Tropical Island Gallery</h1>

  <div class="meta">
    Instance: ${hostname} ·
    Private IP: ${local_ipv4} ·
    AZ: ${az} ·
    VPC: ${vpc}
  </div>

  <div class="gallery">
    <div class="card">
      <img src="https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExNGZ6OTRsc2ZuOXZxNmpmYWp4ZWJsOWxhNGNqcWljM3podnJibXl2dCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/lLZ4wfQnahdcI/giphy.gif">
      <div class="caption">Photo 1</div>
    </div>
    <div class="card">
      <img src="https://media.tenor.com/6O_Rssu2Ry8AAAAM/bikini-asian.gif">
      <div class="caption">Photo 2</div>
    </div>
    <div class="card">
      <img src="https://media.tenor.com/xw1d8ZzN28sAAAAM/asian-chick-asian.gif">
      <div class="caption">Photo 3</div>
    </div>
  </div>
</div>

</body>
</html>
HTML

systemctl restart httpd
echo "Tropical gallery deployed."
