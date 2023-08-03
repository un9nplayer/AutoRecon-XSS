# AutoRecon-XSS

## Description

AutoRecon-XSS is a script designed for automated reconnaissance of XSS vulnerabilities. It crawls the target URL or alive domains, extracts potentially vulnerable URLs, and checks them for XSS vulnerabilities.

## Table of Contents

- [Installation](#installation)
- [External-tools](#external-tools)
- [Usage](#usage)
- [What New](#what-new)
- [Contact](#contact)
- [Disclaimer](#disclaimer)

## Installation

```sh
git clone https://github.com/un9nplayer/AutoRecon-XSS.git
cd AutoRecon-XSS
chmod +x AutoRecon-XSS.sh
```

## External-tools

- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [qsreplace](https://github.com/tomnomnom/qsreplace)
- [waybackurls](https://github.com/tomnomnom/waybackurls)
- [dalfox](https://github.com/hahwul/dalfox)
- [notify](https://github.com/projectdiscovery/notify)

Installation:

```sh
subfinder: go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
httpx : go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
qsreplace: go install github.com/tomnomnom/qsreplace@latest
waybackurls: go install github.com/tomnomnom/waybackurls@latest
dalfox: go install github.com/hahwul/dalfox/v2@latest
notify: go install -v github.com/projectdiscovery/notify/cmd/notify@latest
```
## Usage

```sh
bash AutoRecon-XSS.sh <Target-URL> <Url-Recon-Year> <"XSS-Payload-you-wanna-Test">
```

Example:

```sh
bash AutoRecon-XSS.sh http://testphp.vulnweb.com 2000 "<script>alert(1)</script>"
```
<p align="center">
<img src=https://github.com/un9nplayer/AutoRecon-XSS/blob/main/image.png width=1000>
<img src=https://raw.githubusercontent.com/un9nplayer/AutoRecon-XSS/main/new.png width=1000>
<img src=https://raw.githubusercontent.com/un9nplayer/AutoRecon-XSS/main/XSS.png width=1000>
</p>

## What-New
- Implemented DalFox to perform a scan on a URL and that will give you 99% positive results.
- Run DalFox scan on vulnerable URLs: Runs DalFox scan on vulnerable URLs if a specific file exists.
- Print vulnerability check completion message: Displays a completion message for the vulnerability check.
- Check and display the results: Check and displays the results of the vulnerability check.
- Start where you left off.
- Notify: The tool tries to use the default provider config `($HOME/.config/notify/provider-config.yaml)`, it can also be specified via CLI by using the provider-config flag.

This will display all new support tools.

| New Update              | Description                                        |
|-------------------------|----------------------------------------------------|
| `Notify`                | Directly send the data to Discord webhook.         |
| `Dalfox`		            | Scan vulnerable urls to check the confirmed XSS.   | 

<p align="center">
<img src=https://raw.githubusercontent.com/un9nplayer/AutoRecon-XSS/main/Subdomain.png width=400>
<img src=https://raw.githubusercontent.com/un9nplayer/AutoRecon-XSS/main/XSS-confirm.png width=400>
</p>

## Contact

You can reach out to the author via the following channels:

- [Twitter](https://twitter.com/Un9nPlayer)
- [Instagram](https://instagram.com/Un9nPlayer)

## Disclaimer

Please use AutoRecon-XSS responsibly and only for ethical purposes. Always adhere to legal and ethical standards when conducting security assessments or vulnerability scanning. The author and contributors of AutoRecon-XSS are not responsible for any misuse or illegal activities conducted with this tool.

AutoRecon-XSS is made with 🖤 by the un9nplayer.
