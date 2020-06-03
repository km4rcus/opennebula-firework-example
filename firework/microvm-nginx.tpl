CPU = "1"
MEMORY = "1024"
DISK = [
  IMAGE="nginx@stable-alpine",
  TARGET="vda" 
]
DISK = [
  IMAGE="web-data",
  TARGET="vdb" 
]
NIC = [
  NETWORK = "vnet",
]
OS = [
  KERNEL_CMD = "console=ttyS0 reboot=k panic=1 pci=off",
  KERNEL_DS = "$FILE[IMAGE=\"alpine-kernel\"]" 
]
GRAPHICS = [
  LISTEN = "0.0.0.0",
  TYPE = "VNC" 
]
CONTEXT = [
  NETWORK = "YES",
  FILES_DS = "$FILE[IMAGE=\"nginx.conf\"]",
  SET_HOSTNAME = "website",
  SSH_PUBLIC_KEY = "$USER[SSH_PUBLIC_KEY]",
  START_SCRIPT = "mkdir -p /context
mount /dev/vdc /context
cp /context/nginx.conf /etc/nginx/nginx.conf
formatted=$(blkid /dev/vdb)
if [[ ! $formatted ]]; then
  mkfs -t ext4 /dev/vdb
fi
mount /dev/vdb /web-data
wget -O /web-data/index.html http://raw.githubusercontent.com/km4rcus/opennebula-firework-example/master/html/index.html
nginx -c /etc/nginx/nginx.conf"
]
