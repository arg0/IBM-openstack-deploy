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
	config_file_path=/mnt/gentoo/opt/lbs/conf/host_profile
else
	mkdir -p /opt/lbs/conf
	config_file_path=/opt/lbs/conf/host_profile
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
#set  node_type

	node_type="COMPUTE"
	echo "Please input node_type:(CONTROL | CONTROL_HA | COMPUTE | STORAGE)"
	read -p "(Default node_type: COMPUTE):" node_type
	if [ "$node_type" = "" ]; then
		node_type="COMPUTE"
	fi
	echo "==========================="
	echo node_type="$node_type"
	echo "==========================="
	echo node_type="$node_type" > $config_file_path

#set admin_interface
	
	admin_interface="eth0"
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
	
	vm_interface="eth0"
	echo "Please input the vm_interface :(eth0 or eth1)"
	read -p "(Default is eth0 ):" vm_interface
	if [ "$vm_interface" = "" ]; then
		vm_interface="eth0"
	fi
	echo "==========================="
	echo vm_interface="$vm_interface"
	echo "==========================="
	echo vm_interface="$vm_interface" >> $config_file_path

#set admin_ip
	
	admin_ip="192.168.0.10"
	echo "Please input the admin_ip :(like xxx.xxx.xxx.xxx)"
	read -p "(Default is 192.168.0.10 ):" admin_vlan
	if [ "$admin_ip" = "" ]; then
		admin_ip="192.168.0.10"
	fi
	echo "==========================="
	echo admin_ip="$admin_ip"
	echo "==========================="
	echo admin_ip="$admin_ip" >> $config_file_path

#set vm_ip
	
	vm_ip="10.1.1.10"
	echo "Please input the vm_ip :(like xxx.xxx.xxx.xxx)"
	read -p "(Default is 10.1.1.10 ):" admin_vlan
	if [ "$vm_ip" = "" ]; then
		vm_ip="10.1.1.10"
	fi
	echo "==========================="
	echo vm_ip="$vm_ip"
	echo "==========================="
	echo vm_ip="$vm_ip" >> $config_file_path


echo "====================================================================="
echo "====================================================================="
echo "=========================== Check install ==========================="
if [ $(ls /mnt/gentoo/opt/lbs/conf/host_profile 2>>/dev/null) ] || [ $(ls /opt/lbs/conf/host_profile 2>>/dev/null) ]; then
  echo "cloud_profile [found]"
  else
  echo "Error: cloud_profile not found!!!"
fi
echo "=========================== Check install ==========================="
if [ $(ls /mnt/gentoo/opt/lbs/conf/host_profile 2>>/dev/null) ] || [ $(ls /opt/lbs/conf/host_profile 2>>/dev/null) ]; then
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
