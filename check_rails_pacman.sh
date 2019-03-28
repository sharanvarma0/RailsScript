#!/bin/bash

####################################################################################################
#                                                                                                  #
# This is a bash script that can be used to acertain whether ruby on rails is installed or not 	   #
# This only works on pacman based systems. The options and logic follows pacman workings	   #
# This will be distributed under the GNU GPL License. Feel free to suggest or make changes to it   #
#                                                                                                  #
####################################################################################################



echo "[*] Installing Packages require ROOT Permission"

pkglist="git zlib gcc patch readline libyaml libffi openssl make bzip2 autoconf automake libtool bison curl sqlite"
flag=true

RAILS="rails"
ACTIVERECORD="activerecord"
NODEJS="nodejs"
DATABASE="postgresql"
touch .output.txt


## check whether base packages exist ##
echo "[*] Querying the Existence of Base Packages for Ruby on Rails..."

for pkg in $pkglist
do
	if (pacman -Qi $pkg 2>/dev/null 1>./output.txt)
	then
		echo "[+] $pkg already Installed"
	else
		echo "[*] Trying to Install..."
		if (sudo pacman -S $pkg 2>/dev/null)
		then
			echo "[+] $pkg Sucessfully Installed"
			flag=true
		else
			echo "[-] $pkg Failed to Install"
			flag=false
		fi
	fi
done

echo "[*] Querying whether Rails Exists"
if (gem list --local $RAILS 2>/dev/null 1>./output.txt)
then
	echo "[+] Rails Already Installed"
else
	echo "[-] Rails Not Installed"
	echo "[*] Installing Rails..."
	if (sudo gem install $RAILS 2>/dev/null)
	then
		echo "[+] Rails Installed Sucessfully"
		flag=true
	else
		echo "[-] Rails Failed to Install"
		echo "[*] Some Errors Occured"
		flag=false
	fi
fi

echo "[*] Querying Existence of JS Runtime Libraries"
if (pacman -Qi $NODEJS 2>/dev/null 1>./output.txt)
then
	echo "[+] $NODEJS Already Installed"
	flag=true
else
	echo "[-] $NODEJS Not installed"
	echo "[*] Trying to install $NODEJS (Type y for YES and n for NO"
	if (sudo pacman -S $NODEJS 2>/dev/null)
	then
		echo "[+] $NODEJS Installed"
		flag=true
	else
		echo "[+] $NODEJS Failed to Install"
		flag=false
	fi
fi

echo "[*] Querying Existence of $DATABASE"
if (pacman -Qi $DATABASE 2>/dev/null 1>./output.txt)
then
	echo "[+] $DATABASE Already Installed"
	flag=true
else
	echo "[-] $DATABASE not Installed"
	echo "[*] Trying to install $DATABASE"
	if (sudo pacman -S $DATABASE 2>/dev/null 1>./output.txt)
	then
		echo "[+] $DATABASE Installed Sucessfully"
		flag=true
	else
		echo "[-] Error in installing $DATABASE"
		flag=false
	fi
fi

if ("$flag" = true)
then
	echo "[+] All Packages Installed Sucessfully"
else
	echo "[-] Some Packages were not installed"
fi

rm ./output.txt




		



