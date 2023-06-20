# AutoRecon-XSS

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Description

AutoRecon-XSS is a script designed for automated reconnaissance of XSS vulnerabilities. It crawls the target URL or alive domains, extracts potential vulnerable URLs, and checks them for XSS vulnerabilities.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contact](#contact)
- [Disclaimer](#disclaimer)

## Installation

```bash
git clone https://github.com/un9nplayer/AutoRecon-XSS.git
cd AutoRecon-XSS
chmod +x AutoRecon-XSS.sh
```
## External tools

- [Subfinder](https://github.com/projectdiscovery/subfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [qsreplace](https://github.com/tomnomnom/qsreplace)

Installation:

```bash
subfinder: go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
httpx : go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
qsreplace: go install github.com/tomnomnom/qsreplace@latest
```
## Usage

```bash
bash AutoRecon-XSS.sh <Target-URL> <Url-Recon-Year> <"XSS-Payload-you-wanna-Test">
```

Example:

```bash
bash AutoRecon-XSS.sh http://testphp.vulnweb.com 2000 "<script>alert(1)</script>"
```
<img src=https://github.com/un9nplayer/AutoRecon-XSS/blob/main/image.png width=1000>

## Contact

You can reach out to the author via the following channels:

- [Twitter](https://twitter.com/Un9nPlayer)
- [Instagram](https://instagram.com/Un9nPlayer)

## Disclaimer

Please use AutoRecon-XSS responsibly and only for ethical purposes. Always adhere to legal and ethical standards when conducting security assessments or vulnerability scanning. The author and contributors of AutoRecon-XSS are not responsible for any misuse or illegal activities conducted with this tool.
