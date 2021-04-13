#!/bin/bash
cwd=$PWD

CONFIG_DIR=/etc/generate-csr
CONFIG_FILENAME=config
domain="null"
certs_location="certs/"
generate_secure_zip=false

for arg in "$@"; do
	key=`echo "$arg" | awk -F "=" '{print $1}'`
	value=`echo "$arg" | awk -F "=" '{print $2}'`

	if [[ $key == "--config_path" ]]; then
		CONFIG_DIR=`dirname $value`
		CONFIG_FILENAME=`basename $value`
	elif [[ $key == "--domain" ]]; then
		domain=$value
	elif [[ $key == "--certs_location" ]]; then
		certs_location=$value
	elif [[ $key == "--generate-secure-zip" ]]; then
		generate_secure_zip=true
	fi
done

# These variables depend on configurable parameters above
CONFIG_PATH="$CONFIG_DIR/$CONFIG_FILENAME"

if [ "$domain" = "null" ]; then
	echo "Domain must be defined"
	exit 1
fi

if [ -f $CONFIG_PATH ]; then
	# exists
	source $CONFIG_PATH
else
	# does not exist
	read -r -p "Configuration file not found at $CONFIG_PATH. Create? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo -n "Making folder ."
		sudo mkdir -p "$CONFIG_DIR" 2> /dev/null
		echo " Done"

		echo -n "Enter ISO 3166 2 digit country code [ENTER]: "
		read country

		echo -n "Enter state name [ENTER]: "
		read state

		echo -n "Enter locality (city name) [ENTER]: "
		read locality

		echo -n "Enter organisation name [ENTER]: "
		read organisation

		echo -n "Enter organisation unit [ENTER]: "
		read organisationalUnit

		echo -n "Writing configuration file "
		sudo touch $CONFIG_PATH
		echo -n ". "
		echo "country=\"$country\"" | sudo tee --append $CONFIG_PATH > /dev/null
		echo -n ". "
		echo "state=\"$state\"" | sudo tee --append $CONFIG_PATH > /dev/null
		echo -n ". "
		echo "locality=\"$locality\"" | sudo tee --append $CONFIG_PATH > /dev/null
		echo -n ". "
		echo "organisation=\"$organisation\"" | sudo tee --append $CONFIG_PATH > /dev/null
		echo -n ". "
		echo "organisationalUnit=\"$organisationalUnit\"" | sudo tee --append $CONFIG_PATH > /dev/null
		echo -n ". "
		echo "Done"
	else
		echo "Exiting ... "
		exit 1
	fi
fi

# Main program starts here
keyPath=$domain.key
keyorgPath=$keyPath.org
csrPath=$domain.csr
zipPath=$domain.zip
logPath=$domain.log

if [ -d "$certs_location$domain" ]; then
	echo "Certificate already exists,"
	echo "Please delete the folder and try again"
	exit 1
fi

mkdir -p "$certs_location$domain"
cd "$certs_location$domain"

password=`openssl rand -base64 16`
echo $password > $domain.password

echo -n "Generating private key for $domain"
openssl genrsa -aes256 -out $keyPath -passout pass:$password 2048 >> $logPath 2>&1
echo " Done"

echo -n "Removing passphrase from private key"
cp $keyPath $keyorgPath > /dev/null
openssl rsa -in $keyorgPath -out $keyPath -passin pass:$password >> $logPath 2>&1
echo " Done"

echo -n "Generate certificate signing request (CSR)"
subject="/C=$country/ST=$state/L=$locality/O=$organisation/OU=$organisationalUnit/CN=$domain"
openssl req -new -key $keyPath -out $csrPath -subj "$subject" >> $logPath 2>&1
echo " Done"

if [ "$generate_secure_zip" = true ]; then
	echo -n "Generating encrypted zip"
	7za a -tzip -p"$password" -mem=AES256 $zipPath $keyPath >> $logPath 2>&1
	echo " Done"
fi

echo ""
echo ""
echo "CSR for $domain"
cat "$csrPath"
if [ "$generate_secure_zip" = true ]; then
	echo ""
	echo "Passphrase for zip: $password"
fi

cd "$cwd"
