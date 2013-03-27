#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to set the install"
    exit 1
fi

clear
echo "====================================================================="
echo "           IBM Assert Team v0.1 for CentOS/RadHat Linux "
echo "====================================================================="
echo "      A tool to auto-restore system on Linux "
echo ""
echo "      For more information please visit http://www.ibm.com/"
echo "====================================================================="


if [ $(ls /mnt/gentoo 2>>/dev/null) ]; then
	mkdir -p /mnt/gentoo/opt/lbs/conf
	config_file_path=/mnt/gentoo/opt/lbs/conf/cloud_profile
else
	mkdir -p /opt/lbs/conf
	config_file_path=/opt/lbs/conf/cloud_profile
fi

cur_dir=$(pwd)

if [ "$1" != "--help" ]; then

get_char()
{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
    stty echo
    stty $SAVEDSTTY
}

# User Licence
        
	
	echo "====================================================================="
	echo "                         IBM System Licence"
	echo "====================================================================="

	echo "IBM-International Business Machines Corporation or its subsidiaries."
	echo "The Program is owned by IBM or an IBM supplier, and is copyrighted "
	echo "and licensed, not sold."
	echo "a. Licensee has lawfully obtained the Program and complies with the "
	echo "terms of this Agreement;"
	echo "b. the backup copy does not execute unless the backed-up Program    "
	echo "cannot execute;"
	echo "c. Licensee reproduces all copyright notices and other legends of   "
	echo  "ownership on each copy, or partial copy, of the Program;"
	echo "d. Licensee ensures that anyone who uses the Program (accessed either"
	echo "locally or remotely) 1) does so only on Licensee's behalf and 2)    "
    echo "complies with the terms of this Agreement;"
	echo "e. Licensee does not 1) use, copy, modify, or distribute the Program "
	echo "except as expressly permitted in this Agreement; 2) reverse assemble,"
	echo "reverse compile, otherwise translate, or reverse engineer the Program"
	echo "except as expressly permitted by law without the possibility of      "
	echo "contractual waiver; 3) use any of the Program's components, files,   "
	echo "modules,audio-visual content,or related licensed materials separately"
	echo "from that Program; or 4) sublicense, rent, or lease the Program;     "
	echo "Press ENTER view next page"
	nextpage=`get_char`
	clear
	echo "====================================================================="
	echo "                         IBM System Licence"
	echo "====================================================================="

	echo "f. if Licensee obtains this Program as a Supporting Program, Licensee"
	echo "uses this Program only to support Principal Program and subject to   "
	echo "any limitations in the license to the Principal Program, or, if      "
	echo "Licensee obtains this Program as a Principal Program, Licensee uses  "
	echo "all Supporting Programs only to support this Program, and subject to "
	echo "any limitations in this Agreement. For purposes of this Item f a     "
	echo "'Supporting Program' is a Program that is part of another IBM Program"
	echo " ('Principal Program') and identified as a Supporting Program in the "
	echo "Principal Program's LI. (To obtain a separate license to a Supporting"
	echo " Program without these restrictions,Licensee should contact the party"
	echo " from whom Licensee obtained the Supporting Program.)" 

	echo "====================================================================="
	echo ""
	echo ""




	echo "====================================================================="
	accpetlicence="n"
	echo "Do you AGREE the user licence ?(yes or no)"
	read -p "(Default no,if you want please input: y ,if not please press the enter button):" acceptlicence
        case "$acceptlicence" in
        y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
        echo "You will install the System"
        acceptlicence="y"
        ;;
        n|N|No|NO|no|nO)
        echo "You will NOT install the System !"
        acceptlicence="n"
	echo "Press any key to EXIT !!"
	exit 1
        ;;
        *)
        echo "INPUT error,The System will NOT install!"
        acceptlicence="n"
        esac
        get_char()
        {
        	SAVEDSTTY=`stty -g`
 	        stty -echo
			stty cbreak
			dd if=/dev/tty bs=1 count=1 2> /dev/null
			stty -raw
			stty echo
			stty $SAVEDSTTY
		}
		char=`get_char`

if [ $acceptlicence == "y" ] ; then


echo "Then the configure process :"
echo "++++++++++++++++++++++++++++"

##############################################################
#set main domain name

	domain="www.ibm.com"
	echo "Please input domain:"
	read -p "(Default domain: www.ibm.com):" domain
	if [ "$domain" = "" ]; then
		domain="www.ibm.com"
	fi
	echo "==========================="
	echo domain="$domain"
	echo "==========================="
	echo domain="$domain" > $config_file_path

#set mysql root password

	echo "==========================="

	mysqlrootpwd="root"
	echo "Please input the root password of mysql:"
	read -p "(Default password: root):" mysqlrootpwd
	if [ "$mysqlrootpwd" = "" ]; then
		mysqlrootpwd="root"
	fi
	echo "==========================="
	echo mysqlrootpwd="$mysqlrootpwd"
	echo "==========================="
	echo mysqlrootpwd="$mysqlrootpwd" >> $config_file_path

#set system root password

	sysrootpasswd="root"
	echo "Please input system root password:"
	read -p "(Default passwd: root):" sysrootpasswd
	if [ "$sysrootpasswd" = "" ]; then
		sysrootpasswd="root"
	fi
	echo "==========================="
	echo systemrootpasswd="$sysrootpasswd"
	echo "==========================="
	echo systemrootpasswd="$sysrootpasswd">> $config_file_path
#set ntp_server
	
	ntp_server=""
	echo "Please input the ntp_server ip address:"
	read -p "(Default ip address is NULL):" ntp_server
	if [ "$ntp_server" = "" ]; then
		ntp_server=""
	fi
	echo "==========================="
	echo ntp_server="$ntp_server"
	echo "==========================="
	echo ntp_server="$ntp_server" >> $config_file_path

#set dns_server
	
	dns_server=""
	echo "Please input the dns_server  ip address:"
	read -p "(Default ip address is NULL):" dns_server
	if [ "$dns_server" = "" ]; then
		dns_server=""
	fi
	echo "==========================="
	echo dns_server="$dns_server"
	echo "==========================="
	echo dns_server="$dns_server" >> $config_file_path

#set admin_interface
	
	admin_interface=""
	echo "Please input the admin_interface :(eth0 or eth1)"
	read -p "(Default is eth0 ):" admin_interface
	if [ "$admin_interface" = "" ]; then
		admin_interface="eth0"
	fi
	echo "==========================="
	echo admin_interface="$admin_interface"
	echo "==========================="
	echo admin_interface="$admin_interface" >> $config_file_path

#set vm_interface
	
	vm_interface=""
	echo "Please input the vm_interface :(eth0 or eth1)"
	read -p "(Default is eth0 ):" vm_interface
	if [ "$vm_interface" = "" ]; then
		vm_interface="eth0"
	fi
	echo "==========================="
	echo vm_interface="$vm_interface"
	echo "==========================="
	echo vm_interface="$vm_interface" >> $config_file_path

#set admin_vlan
	
	admin_vlan=""
	echo "Please input the admin_vlan :(0~4096)"
	read -p "(Default is 0 ):" admin_vlan
	if [ "$admin_vlan" = "" ]; then
		admin_vlan="0"
	fi
	echo "==========================="
	echo admin_vlan="$admin_vlan"
	echo "==========================="
	echo admin_vlan="$admin_vlan" >> $config_file_path

#set admin_subnet
	
	admin_subnet=""
	echo "Please input the admin_subnet :(like xxx.xxx.xxx.0)"
	read -p "(Default is 192.168.1.0 ):" admin_subnet
	if [ "$admin_subnet" = "" ]; then
		admin_subnet="192.168.1.0"
	fi
	echo "==========================="
	echo admin_subnet="$admin_subnet"
	echo "==========================="
	echo admin_subnet="$admin_subnet" >> $config_file_path

#set admin_netmask
	
	admin_netmask=""
	echo "Please input the admin_netmask :(like xxx.xxx.xxx.xxx)"
	read -p "(Default is 255.255.255.0 ):" admin_netmask
	if [ "$admin_netmask" = "" ]; then
		admin_netmask="255.255.255.0"
	fi
	echo "==========================="
	echo admin_netmask="$admin_netmask"
	echo "==========================="
	echo admin_netmask="$admin_netmask" >> $config_file_path

#set admin_router
	
	admin_router=""
	echo "Please input the admin_router :(like xxx.xxx.xxx.1)"
	read -p "(Default is 192.168.0.1 ):" admin_router
	if [ "$admin_router" = "" ]; then
		admin_router="192.168.0.1"
	fi
	echo "==========================="
	echo admin_router="$admin_router"
	echo "==========================="
	echo admin_router="$admin_router" >> $config_file_path

#set admin_broadcast
	
	admin_broadcast=""
	echo "Please input the admin_broadcast :(like xxx.xxx.xxx.255)"
	read -p "(Default is 192.168.0.255 ):" admin_broadcast
	if [ "$admin_broadcast" = "" ]; then
		admin_broadcast="192.168.0.255"
	fi
	echo "==========================="
	echo admin_broadcast="$admin_broadcast"
	echo "==========================="
	echo admin_broadcast="$admin_broadcast" >> $config_file_path

#set admin_range
	
	admin_range=""
	echo "Please input the admin_range :"
	read -p "(Default is 192.168.0.0/24 ):" admin_range
	if [ "$admin_range" = "" ]; then
		admin_range="192.168.0.0/24"
	fi
	echo "==========================="
	echo admin_range="$admin_range"
	echo "==========================="
	echo admin_range="$admin_range" >> $config_file_path

##################################################################
#set vm_vlan
	
	vm_vlan=""
	echo "Please input the vm_vlan :(0~4096)"
	read -p "(Default is 0 ):" vm_vlan
	if [ "$vm_vlan" = "" ]; then
		vm_vlan="0"
	fi
	echo "==========================="
	echo vm_vlan="$vm_vlan"
	echo "==========================="
	echo vm_vlan="$vm_vlan" >> $config_file_path

#set vm_subnet
	
	vm_subnet=""
	echo "Please input the vm_subnet :(like xxx.xxx.xxx.0)"
	read -p "(Default is 10.1.1.0 ):" vm_subnet
	if [ "$vm_subnet" = "" ]; then
		vm_subnet="10.1.1.0"
	fi
	echo "==========================="
	echo vm_subnet="$vm_subnet"
	echo "==========================="
	echo vm_subnet="$vm_subnet" >> $config_file_path

#set vm_netmask
	
	vm_netmask=""
	echo "Please input the vm_netmask :(like xxx.xxx.xxx.xxx)"
	read -p "(Default is 255.255.255.0 ):" vm_netmask
	if [ "$vm_netmask" = "" ]; then
		vm_netmask="255.255.255.0"
	fi
	echo "==========================="
	echo vm_netmask="$vm_netmask"
	echo "==========================="
	echo vm_netmask="$vm_netmask" >> $config_file_path

#set vm_router
	
	vm_router=""
	echo "Please input the vm_router :(like xxx.xxx.xxx.1)"
	read -p "(Default is 10.1.1.1 ):" vm_router
	if [ "$vm_router" = "" ]; then
		vm_router="10.1.1.1"
	fi
	echo "==========================="
	echo vm_router="$vm_router"
	echo "==========================="
	echo vm_router="$vm_router" >> $config_file_path

#set vm_broadcast
	
	vm_broadcast=""
	echo "Please input the vm_broadcast :(like xxx.xxx.xxx.255)"
	read -p "(Default is 10.1.1.255 ):" vm_broadcast
	if [ "$vm_broadcast" = "" ]; then
		vm_broadcast="10.1.1.255"
	fi
	echo "==========================="
	echo vm_broadcast="$vm_broadcast"
	echo "==========================="
	echo vm_broadcast="$vm_broadcast" >> $config_file_path

#set vm_range
	
	vm_range=""
	echo "Please input the vm_range :"e 
	read -p "(Default is 10.1.1.0/24 ):" vm_range
	if [ "$vm_range" = "" ]; then
		vm_range="10.1.1.0/24"
	fi
	echo "==========================="
	echo vm_range="$vm_range"
	echo "==========================="
	echo vm_range="$vm_range" >> $config_file_path

######################################################################
#set admin_ha_host
	
	admin_ha_host=""
	settheha
	echo "Do you want the HA HOST ?"
	read -p "(Default no,if you want please input: y ,if not ,press the enter button):" settheha
        case "$settheha" in
        y|Y|Yes|YES|yes|yES|yEs|YeS|yeS)
        echo "You will set the HA HOST"
        settheha="y"
		    echo "Please input the MAC address for admin_ha_host :"
			read -p "(Default is FF-FF-FF-FF-FF-FF ):" admin_ha_host
			if [ "$admin_ha_host" = "" ]; then
				admin_ha_host="FF-FF-FF-FF-FF-FF"
			fi
			echo "==========================="
			echo admin_ha_host="$admin_ha_host"
			echo "==========================="
			echo admin_ha_host="$admin_ha_host" >> $config_file_path
        ;;
        n|N|No|NO|no|nO)
        echo "You will NOT set the HA HOST "
        settheha="n"
		echo "Press any key to NEXT STEP !!"
	    ;;
        *)
        echo "INPUT error,skip to NEXT STEP !!"
        settheha="n"
        esac
        get_char()
        {
        	SAVEDSTTY=`stty -g`
 	        stty -echo
			stty cbreak
			dd if=/dev/tty bs=1 count=1 2> /dev/null
			stty -raw
			stty echo
			stty $SAVEDSTTY
		}
	
	char=`get_char`

#####################################################################
#set storage_host
	
	storage_host=""
	echo "Please input the MAC address for storage_host  :"
	read -p "(Default is FF-FF-FF-FF-FF-FF ):" storage_host
	if [ "$storage_host" = "" ]; then
		storage_host="FF-FF-FF-FF-FF-FF"
	fi
	echo "==========================="
	echo storage_host="$storage_host"
	echo "==========================="
	echo storage_host="$storage_host" >> $config_file_path

#set admin_email
	
	admin_email=""
	echo "Please input the admin_email  :"
	read -p "(Default is admin@admin.com ):" admin_email
	if [ "$admin_email" = "" ]; then
		admin_email="admin@admin.com"
	fi
	echo "==========================="
	echo admin_email="$admin_email"
	echo "==========================="
	echo admin_email="$admin_email" >> $config_file_path	

#set mail_server
	
	mail_server=""
	echo "Please input the ip address for mail_server :(like xxx.xxx.xxx.xxx)"
	read -p "(Default is  ):" mail_server
	if [ "$mail_server" = "" ]; then
		mail_server=""
	fi
	echo "==========================="
	echo mail_server="$mail_server"
	echo "==========================="
	echo mail_server="$mail_server" >> $config_file_path	





echo "====================================================================="
echo "====================================================================="
echo "=========================== Check install ==========================="
if [ $(ls /mnt/gentoo/opt/lbs/conf/cloud_profile 2>>/dev/null) ] || [ $(ls /opt/lbs/conf/cloud_profile 2>>/dev/null) ]; then
  echo "cloud_profile [found]"
  else
  echo "Error: cloud_profile not found!!!"
fi
echo "=========================== Check install ==========================="
if [ $(ls /mnt/gentoo/opt/lbs/conf/cloud_profile 2>>/dev/null) ] || [ $(ls /opt/lbs/conf/cloud_profile 2>>/dev/null) ]; then
echo "Congratulations!"
echo ""
echo "PATH:" $config_file_path
echo "Configure completed! enjoy it!"
date
echo "====================================================================="
echo "           IBM Assert Team v0.1 for CentOS/RadHat Linux "
echo "====================================================================="
echo "      A tool to auto-restore system on Linux "
echo ""
echo "      For more information please visit http://www.ibm.com/"
echo "====================================================================="

else
  echo "Sorry,Failed to configure !"
  echo "Please contact IBM with feedback errors and logs."
fi
fi
fi
