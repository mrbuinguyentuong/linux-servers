#!/bin/sh
#Get list cloudflare ip (IPv4)
curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cf_ips

#Add whitelist
for cfip in `cat /tmp/cf_ips`; do firewall-cmd --permanent --zone=public --add-source=$cfip; done
#Set the range of ports
firewall-cmd --permanent --zone=public --add-port={80/tcp,443/tcp}

# Reload
firewall-cmd --reload > /dev/null


firewall-cmd --permanent --zone=public --add-rich-rule='rule family="ipv4" source address="0.0.0.0" port port="22" protocol="tcp" accept'



firewall-cmd --permanent --zone=drop --add-rich-rule='rule family="ipv4" source address="0.0.0.1" port port="22" protocol="tcp" accept'

firewall-cmd --permanent --zone=drop --add-rich-rule='rule family="ipv4" source address="0.0.0.2" port port="22" protocol="tcp" accept'




sudo firewall-cmd --permanent --zone=work --add-source=173.245.48.0/20
sudo firewall-cmd --permanent --zone=drop --add-port=21/tcp



firewall-cmd --permanent --zone=work --add-source=173.245.48.0/20

firewall-cmd --permanent --zone=work --add-port={21/tcp,443/tcp}

firewall-cmd --permanent --zone=drop --add-port={80/tcp,443/tcp}

firewall-cmd --permanent --zone=work --add-port={80/tcp,443/tcp}

firewall-cmd --permanent --zone=drop --remove-source=173.245.48.0/20

firewall-cmd --permanent --zone=drop --add-port={21/tcp}


sudo firewall-cmd --set-default-zone=drop

sudo firewall-cmd --reload



#Install vsftpd

sudo adduser ftp_your_user / your-password

sudo bash -c 'echo ftp_your_user >> /etc/vsftpd/user_list'


sudo mkdir -p /var/www/ftp_your_user/ftp/upload
sudo chmod 550 /var/www/ftp_your_user/ftp
sudo chmod 750 /var/www/ftp_your_user/ftp/upload
sudo chown -R ftp_your_user:ftp_your_user /var/www/ftp_your_user/ftp


https://news.cloud365.vn/firewall-phan-2-firewalld-service/
