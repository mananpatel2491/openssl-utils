# Version : 0.1
# Creatin Date : Nov 19, 2018
# Author : Manan Patel: manampatel007@gmail.com
# Description : Openssl util script for Cygwin bash console

############ Version History ###################
## Number - Date  ## Revision History ##################
## 0.1 - 20181119 ## Created a draft skeletion for script execution. Added list of activities to support.
############ Version History ###################

echo This is Openssl Util Version 0.1

echo -e "\n"

echo -e "1: Openssl Dump
2: Conversion
3: RSA Key
4: ECC Key
5: P12 Store"

echo -e "Please select any one option from below, based on your requirement:"
read userInput1


case "$userInput1" in
"1")
	echo -e "\nPlease provide file/curve name:"
	read dumpInput
	
	#echo "Selected file is : ${dumpInput}"
	if [ -f "${dumpInput}" ]
	then
		echo "File found."
	else
		echo "File does not exist. Please try again."
		exit
	fi
	
	echo -e "
1: X509 Cert - DER
2: X509 Cert - PEM
3: CRL - DER
4: CRL - PEM
5: ECC Curve Params

Please select File Type"
	read userInput2
	##echo "Selected input is : ${userInput2}"
	
	case "$userInput2" in
	"1")
		openssl x509 -inform DER -in "${dumpInput}" -text -noout
		;;
	"2")
		openssl x509 -in "${dumpInput}" -text -noout
		;;
	"3")
		openssl crl -inform DER -in "${dumpInput}" -text -noout
		;;
	"4")
		openssl crl -in "${dumpInput}" -text -noout
		;;
	"5")
		openssl ecparam -name "${dumpInput}" -text -noout
		;;
	*)
		echo "Invalid selection. Please try again."
		;;
	esac
	;;

"2")
	echo -e "\nPlease provide source file name:"
	read srcInput
	
	#echo "Selected file is : ${srcInput}"
	if [ -f "${srcInput}" ]
	then
		echo "File found."
	else
		echo "File does not exist. Please try again."
		exit
	fi
	
	echo -e "\nPlease provide destination file name:"
	read dstnInput

	echo -e "
1: X509 Cert: PEM to DER
2: X509 Cert: DER to PEM
3: CRL: PEM to DER
4: CRL: DER to PEM
5: Public Key: PEM to DER
6: Public Key: DER to PEM
7: Private Key: PK8 to PEM
8: P7b Certchain to PEM

Please select converstion type:"
	
	read userInput2
	##echo "Selected input is : ${userInput2}"
	
	case "$userInput2" in
	"1")
		openssl x509 -outform DER -in "${srcInput}" -out "${dstnInput}"
		;;
	"2")
		openssl x509 -inform DER -in "${srcInput}" -out "${dstnInput}"
		;;
	"3")
		openssl crl -outform DER -in "${srcInput}" -out "${dstnInput}"
		;;
	"4")
		openssl crl -inform DER -in "${srcInput}" -out "${dstnInput}"
		;;
	"5")
		openssl rsa -pubin -in "${srcInput}" -outform DER -out "${dstnInput}"
		;;
	"6")
		openssl rsa -pubin -inform DER -in "${srcInput}" -out "${dstnInput}"
		;;
	"7")
		openssl pkcs8 -inform DER -in "${srcInput}" -out "${dstnInput}" -nocrypt
		;;
	"8")
		openssl pkcs7 -inform DER -outform PEM -print_certs -in "${srcInput}" > "${dstnInput}"
		;;
	*)
		echo "Invalid selection. Please try again."
		;;
	esac
	;;
"3")
	echo -e "1: Create RSA Key with passphrase
	2: Remove passphrase from RSA key, input : private key
	3: Add passphrase to RSA Key, input: Plain Text Private Key
	4: Convert PEM key to DER, input: PEM Formatted Key File
	5: Convert PVT key in pk8 to PEM, input: pk8 formatted key file
	6: Create self-signed crt from pem(private key) file, input : private key
	7: Create CSR, input : private key[1.2.3.4=ASN1:UTF8:5]
	8: Verify CSR, input : csr file
	9: Issue a certificate using CA, \"openssl.cnf\" optional but recommended to keep a copy in your CA folder , input: \"certs\" directory, \"certindex.txt\" config file, \"v3.ext\" config file, Issuing CA PVT Key, Issuing CA Cert, Certificate Signing Request
	"
	;;
*)
	echo "Invalid selection. Please try again."
	;;
esac
