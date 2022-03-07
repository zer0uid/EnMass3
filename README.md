<p align="center">

<img src="https://raw.githubusercontent.com/zer0uid/EnMass3/main/enm3_GH_readme.png" alt="EnMass3 Logo"/>

</p>

# EnMass3
EnMass3 is a port scanner that utilizes the functionality of both [masscan](https://github.com/robertdavidgraham/masscan) and [nrich](https://gitlab.com/shodan-public/nrich). The tool was built with the mindset of scanning the internet to find vulnerable endpoints, but **FOR THE ENTIRE INTERNET**.

Port scanning is in the **grey area**, you should scan **ONLY** if you have permission from the apprioriate organization.

Masscan asynchronously scans the ip ranges as a **CIDR** notation, and parses the alive host to nrich to gather vulnerability information about each port found by the scan. With nrich, it will generate a newly created output, with clear coloring between ports and CVEs of the ip addresses.

The [AntiScanIPList.txt](https://github.com/zer0uid/EnMass3/blob/main/AntiScanIPList.txt "AntiScanIPList.txt") is a list which includes IP ranges. These IPs will be excluded for the safety of the users. This list does not offer all IPs to be blacklisted, the user can add additional IPs if they so choose. 

*Use at your own risk. Please read the Disclaimer.*

## Dependencies
* Nrich
* Masscan
* jq

*If you do not have these tools installed, EnMass3 will install them.*

## Installation
```
git clone https://github.com/zer0uid/EnMass3.git
chmod +x enmass3.sh
```
## Usage
`sudo ./enmass3.sh [Input File]`

Create file with CIDR notations, see below for example:
```ascii
192.168.0.0/16
192.168.1.0/24
172.16.0.0/16
172.16.1.0/24
```

*Be sure to use a VPN to avoid the possibility of getting banned from your ISP.*
## Disclaimer
EnMass3 is supposed to be used in a **legal** manner. We are not responsible for the actions the user takes while using this tool. Please use responsibly.

If you scan an IP range numerous times, you have the possibility of getting banned from your ISP. It is important to use a VPN while using EnMass3.
## Contributors
[Republic of Hackers](https://discord.com/invite/repofhackers)
[zer0uid](https://github.com/zer0uid)
[Abr4Xa5](https://github.com/AbraXa5)
[10splayaSec](https://github.com/10splayaSec)
[kod3r](https://github.com/abhay-khattar)