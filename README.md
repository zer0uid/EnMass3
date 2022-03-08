<p align="center">

<img src="https://raw.githubusercontent.com/zer0uid/EnMass3/main/enm3_GH_readme.png" alt="EnMass3 Logo"/>

</p>

# EnMass3
EnMass3 is a port scanner that has the capability to **scan the entire internet**, detect **vulnerable endpoints**, and provide applicable CVE's.  EnMass3 utilizes the functionality of [masscan](https://github.com/robertdavidgraham/masscan) and [nrich](https://gitlab.com/shodan-public/nrich).

EnMass3 will take an input file with CDIR notation, scan the IP ranges for the top 20 common vulnerable ports.  Once IP and ports are found, the information is parsed
to nrich and the new EnMass3 output file will contain IP, Ports, Tags, and Vulnerabilities of each vulnerable asset found.  Output is currently available in SHELL (aka text) and JSON formats.

**Please Note:** Port scanning is in the **grey area**, you should scan **ONLY** if you have permission from the apprioriate organization.

#### Blacklist Capability
The [AntiScanIPList.txt](https://github.com/zer0uid/EnMass3/blob/main/AntiScanIPList.txt "AntiScanIPList.txt") is the default blacklist included with EnMass3 and will be used automatically during each scan.  This list does not encompass every country or possibility, please add additional IPs to this list if needed.

**Use at your own risk. Please read the Disclaimer.**

## Dependencies
* [Nrich](https://gitlab.com/shodan-public/nrich)
* [Masscan](https://github.com/robertdavidgraham/masscan)
* [jq](https://stedolan.github.io/jq/)

*If you do not have these tools installed, EnMass3 will install them when you run the tool for the first time.*

## Installation
```
git clone https://github.com/zer0uid/EnMass3.git
chmod +x enmass3.sh
```
## Usage
1. Create an `[Input File]` with CDIR notations, example:
File name: `input.txt`
```ascii
192.168.0.0/16
192.168.1.0/24
172.16.0.0/16
172.16.1.0/24
```
2. `sudo ./enmass3.sh [Input File]`
3. Review `EnMass3_output.txt & EnMass3_output.json` files for vulnerable targets.

** IMPORTANT: Use a VPN to avoid the possibility of getting your IP banned from your local ISP.**

## Disclaimer
EnMass3 is supposed to be used in a **legal** manner. We are not responsible for the actions the user takes while using this tool. Please use responsibly.

If you scan an IP range multiple times, there is a possibility of getting your IP blocked from your ISP. **It is important to use a VPN while using EnMass3.**

## Contributors
* [Republic of Hackers](https://discord.com/invite/repofhackers)
* [zer0uid](https://github.com/zer0uid)
* [Abr4Xa5](https://github.com/AbraXa5)
* [10splayaSec](https://github.com/10splayaSec)
* [kod3r](https://github.com/abhay-khattar)