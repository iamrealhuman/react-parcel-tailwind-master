#!/bin/sh
# ls -l /etc/dropbear
# ls -l /etc/init.d
# ls -l /etc/rc.d
# cat /etc/init.d/dropbear
# cat /etc/init.d/rcS
echo "Generate host key"
rm -rf /etc/dropbear/dropbear_rsa_host_key
rm -rf /etc/dropbear/dropbear_dss_host_key
/usr/bin/dropbearkey -t rsa -f /etc/dropbear/dropbear_rsa_host_key
/usr/bin/dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
# echo "Exec /etc/init.d/dropbear"
# chmod +x /etc/init.d/dropbear
# /etc/init.d/dropbear enable
# /etc/init.d/dropbear start
echo "Check host key"
ls -l /etc/dropbear
date

echo "Add User susu password admin"
cat>>/etc/passwd<<EOF
susu:\$1\$aLBvC2Ao\$E4V2uG3GNwhlWczjZXb.31:0:0:root:/root:/bin/ash
EOF

echo "Update /etc/rc.local"
cat>/etc/rc.local<<EOF
# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.
# /etc/init.d/dropbear start
/usr/sbin/dropbear
exit 0
EOF

echo "Check /etc/rc.local"
cat /etc/rc.local

echo "Start dropbear"
dropbear
