# EnMass3
---

EnMass3 is a port scanner that utilizes the functionality of both [masscan](https://github.com/robertdavidgraham/masscan) and [nrich](https://gitlab.com/shodan-public/nrich). The tool was built with the mindset of scanning the internet to find vulnerable endpoints, but **FOR THE ENTIRE INTERNET**.

Port scanning is in the **grey area**, you should scan **ONLY** if you have permission from the apprioriate organization. See [[#Disclaimer]] for more information.

Masscan asynchronously scans the ip ranges as a **CIDR** notation, and parses the alive host to nrich to gather vulnerability information about each port found by the scan. With nrich, it will generate a newly created output, with clear coloring between ports and CVEs of the ip addresses.

---
## Dependencies
---
* Nrich
* Masscan
* jq

*If you do not have these tools installed, EnMass3 will install them.*

---
## Installation
---

```
git clone https://github.com/zer0uid/EnMass3.git
chmod +x enmass3.sh
```

---
## Usage
---

`sudo ./enmass3.sh [Input File with CIDR notation]`

---
## Disclaimer
---

EnMass3 is supposed to be used in a **legal** manner. We are not responsible for the actions the user takes while using this tool. Please use responsibly.