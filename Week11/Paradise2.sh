#!/bin/bash
# Use this for your EC2 user data

# Install Apache
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Create directories
mkdir -p /var/www/html/images
mkdir -p /var/www/html/music

# Get IMDSv2 Token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" || true)

# Request metadata
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

# Download assets
curl -L -o /var/www/html/images/Paradise.jpg \
  "https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/Paradise.jpg"

curl -L -o /var/www/html/music/FandF.m4a \
  "https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/FandF.m4a"

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
    overflow-x:hidden;
  }

  /* 🌊 Moving wave effect */
  .wave {
    position: fixed;
    top: 0;
    left: 0;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at 50% 100%, rgba(0, 50, 120, 0.55), transparent 70%);
    animation: wave 12s infinite linear;
    opacity: 0.55;
    pointer-events: none;
    z-index: 0;
  }

  @keyframes wave {
    0%   { transform: translateX(0)    translateY(0)    rotate(0deg); }
    50%  { transform: translateX(-15%) translateY(-3%) rotate(1deg); }
    100% { transform: translateX(0)    translateY(0)    rotate(0deg); }
  }

  .overlay {
    background:rgba(0,0,0,0.35);
    padding:20px;
    margin:40px auto;
    border-radius:12px;
    max-width:1200px;
    position:relative;
    z-index:1;
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

<!-- 🌊 Moving ocean layer -->
<div class="wave"></div>
<!-- ✨ Sunlight reflections -->
<div class="reflections"></div>


<!-- 🎵 Looping Background Music -->
<audio id="bgmusic" autoplay loop muted playsinline>
  <source src="music/FandF.m4a" type="audio/mp4">
</audio>

<script>
// Mobile autoplay policy requires muted start.
// Unmute and play after a user tap/click.
document.addEventListener("click", function() {
  var audio = document.getElementById("bgmusic");
  audio.muted = false;
  audio.volume = 0.15; // adjust volume (0.0 - 1.0)
  audio.play();
}, { once: true });
</script>

<div class="overlay">
  <h1>Paradise is where hard work pays off and those who succeed can reap the reward!</h1>
  <h1>In paradise, we will be sought after because of the wealth of knowledge we have</h1>
  <h1>Click your choice to make travel plans!</h1>

  <br>

  <div class="gallery">
    <div class="card">
      <a href="https://yasuketoursllc.wixsite.com/website" target="_blank">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian1.gif">
      </a>
      <div class="caption">Japanese</div>
    </div>
    <div class="card">
      <a href="https://www.onthegotours.com/South-Korea">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian2.gif">
      </a>
      <div class="caption">Korean</div>
    </div>
    <div class="card">
      <a href="https://www.chinatravel.com/">
      <img src="https://raw.githubusercontent.com/kuridangocc-boop/Class7-Homework/main/Images/asian3.gif">
      </a>
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
