# Open DNS Finder

A lightweight, parallel DNS benchmark tool designed for finding optimal DNS resolvers for DNS-based VPNs.

This script queries a list of DNS servers simultaneously, verifies if they resolve your specified domain to the correct target IP, and ranks the working servers from fastest to slowest.

## Features
- **Parallel Scanning:** Queries multiple DNS servers at the same time for fast results.
- **Target Verification:** Filters out servers that do not resolve to your target IP.
- **Auto-Sorting:** Automatically ranks working DNS servers by latency (fastest to slowest).

## Prerequisites
This script requires `dig` (part of the `dnsutils` package on Debian/Ubuntu). You can install it using:

sudo apt update && sudo apt install dnsutils -y

Quick Start Guide
1. Prepare the IP List
Put DNS IP addresses you want to test On "ips.txt" File (one IP per line):

2. Configure the Script
Open "open-dns-finder.sh" File in a text editor and set your specific domain and target IP:

DOMAIN="your-domain-here.com"
TARGET_IP="your-target-ip-here"

3. Make the Script Executable
Give the script execution permissions by running:

chmod +x open-dns-finder.sh

4. Run the Scanner
Execute the script:

./open-dns-finder.sh

Once completed, the ranked results will be displayed on your terminal and saved to "sorted_dns.txt" File.
