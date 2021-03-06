shorewall_conf_path = "/etc/shorewall"





file "#{shorewall_conf_path}/rules.d/03_steam.rules" do
	content <<-EOF

# SUPER LONG LINE WARNING
# This line should contain a list of all of the IPs in the CS var in ~/.steam/steam/config/config.vdf

REDIRECT lan:!10.10.15.57,10.10.10.11,10.10.15.250,10.11.12.13    3128      tcp   www   -   103.10.125.134,103.10.125.136,103.10.125.132,162.254.195.23,205.196.6.132,162.254.195.11,208.64.203.26,208.64.200.9,162.254.195.22,208.64.200.7,208.64.200.8,162.254.193.10,162.254.199.130,162.254.195.10,162.254.192.10,162.254.195.15,162.254.195.17,162.254.195.18,162.254.195.14,162.254.195.19,162.254.195.13,162.254.195.20,162.254.195.16,162.254.195.12,162.254.195.21,162.254.193.38,162.254.193.11,162.254.193.39,162.254.193.12,162.254.193.13,162.254.192.14,162.254.193.52,162.254.193.36,162.254.193.50,162.254.193.49,162.254.192.24,162.254.193.20,162.254.193.37,162.254.193.14,162.254.192.17,162.254.192.19,162.254.192.22,162.254.193.51,162.254.192.13,162.254.192.11,162.254.199.139,162.254.192.20,162.254.199.133,162.254.199.136,162.254.199.135,162.254.192.23,162.254.192.15,162.254.199.131,162.254.199.132,162.254.199.137,162.254.192.16,162.254.199.138,162.254.193.21,162.254.192.12,205.196.6.136,162.254.193.40,162.254.199.134,162.254.193.48,162.254.192.21,162.254.193.22,103.10.124.70,103.10.124.20,205.196.6.137,50.242.151.22,50.242.151.26,103.10.124.18,103.10.124.69,103.10.124.67,103.10.124.68,103.10.124.17,103.10.124.22,162.254.193.24,162.254.192.25,162.254.192.18,162.254.193.23

# or this instead
#REDIRECT $FW    3128      tcp   www      -  !127.0.0.0/8,10.10.0.0/16 #,127.0.0.0/8

EOF
	notifies :restart, "service[shorewall]", :delayed
	action :delete #disable for the moment
end

file "#{shorewall_conf_path}/rules.d/05_whitelists.rules" do
	content <<-EOF

ACCEPT lan net:106.186.22.200 tcp 25 # Squid's mail server for PCFP bug reports
ACCEPT lan:10.10.0.0/16 net all  #server subnet


EOF
	notifies :restart, "service[shorewall]", :delayed
end


file "#{shorewall_conf_path}/rules.d/05_internet_inbound.rules" do
	content <<-EOF

ACCEPT net fw tcp 22
ACCEPT net fw tcp 1194
ACCEPT net fw udp 1194


EOF
	notifies :restart, "service[shorewall]", :delayed
end