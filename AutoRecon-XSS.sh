#!/bin/bash

# Function to print colored text
print_color_text() {
    local color="$1"
    local text="$2"
    echo -e "${color}${text}\e[0m"
}

print_color_text "\033[1;34m" "

░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░███████╗░█████╗░░█████╗░███╗░░██╗  ██╗░░██╗░██████╗░██████╗
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░██║  ╚██╗██╔╝██╔════╝██╔════╝
███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝█████╗░░██║░░╚═╝██║░░██║██╔██╗██║  ░╚███╔╝░╚█████╗░╚█████╗░
██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔══██╗██╔══╝░░██║░░██╗██║░░██║██║╚████║  ░██╔██╗░░╚═══██╗░╚═══██╗
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░██║███████╗╚█████╔╝╚█████╔╝██║░╚███║  ██╔╝╚██╗██████╔╝██████╔╝
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚══════╝░╚════╝░░╚════╝░╚═╝░░╚══╝  ╚═╝░░╚═╝╚═════╝░╚═════╝░

                                    [Welcome to AutoRecon XSS!]
                                                  [@un9nplayer]
"


OUTPUT_DIR="ReconTarget"
FINAL_URLS_FILE="${OUTPUT_DIR}/finalUrls.txt"
JS_URLS_FILE="${OUTPUT_DIR}/JSurls.txt"
VULNERABLE_URLS_FILE="${OUTPUT_DIR}/potentialVulnerableUrls.txt"
XSS_VULNERABLE_URLS_FILE="${OUTPUT_DIR}/XSSvulnerableUrls.txt"
SUBDOMAINS_FILE="${OUTPUT_DIR}/Subdomains.txt"
ALIVE_DOMAINS_FILE="${OUTPUT_DIR}/AliveDomain.txt"

#typing_animation
typing_animation() {
  local text=$1
  local delay=$2
  for ((i = 0; i < ${#text}; i++)); do
    echo -ne "\e[1;32m${text:$i:1}\e[0m"
    sleep "$delay"
  done
  echo
}

# Input target URL, starting year, and XSS payload
target="$1"
start_year="$2"
xss_payload="$3"

typing_animation "Welcome to the AutoRecon XSS." 0.01
sleep 1
typing_animation "Be patient, it's working fine! Please wait for a while until AutoRecon completes its job!" 0.01
typing_animation "Checking the URL status!" 0.01


# Check if the target URL is alive and returns status 200 OK using curl
if ! status_code=$(curl -Is -w "%{http_code}" -A "Chrome" -L "${target}" -o /dev/null); then
    print_color_text "\e[1;31m" "Error: The target URL did not return status code 200 OK."
    exit 1
fi

if [[ "${status_code}" != "200" ]]; then
    print_color_text "\e[1;31m" "Error: The target URL did not return status code 200 OK."
    exit 1
fi

print_color_text "\e[1;36m" "Target URL is alive with status 200 OK. Starting the reconnaissance process."

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Check if subfinder is to be used
if [[ ! -z "$target" ]]; then
    read -p $'\e[1;36mDo you want to check for subdomains? (Y/N): \e[0m' check_subdomains
    if [[ "$check_subdomains" == "y" ]]; then
        print_color_text "\e[1;36m" "SubDomains finding start. Please wait!"
        subdomains=$(subfinder -d "$target" --silent)
        if [[ -n "$subdomains" ]]; then
            echo "$subdomains" > "${SUBDOMAINS_FILE}"
            print_color_text "\e[1;36m" "Done, all alive SubDomains saved!"
        else
            print_color_text "\e[1;36m" "No subdomains found."
        fi
        target="$target"
    else
        print_color_text "\e[1;36m" "Thanks! It will make the process a little bit faster."
    fi
fi

# Save alive domains from subdomains file
if [[ -f "${SUBDOMAINS_FILE}" ]]; then
    print_color_text "\e[1;36m" "Finding alive domains from subdomains file."
    httpx -l "${SUBDOMAINS_FILE}" -mc 200 -silent > "${ALIVE_DOMAINS_FILE}"
    print_color_text "\e[1;36m" "Alive domains saved as ${ALIVE_DOMAINS_FILE}."
fi

print_color_text "\e[1;36m" "Wayback Machine crawling process started."
sleep 2

# Function to perform waybackurls and save the output
perform_waybackurls() {
    local target="$1"
    local output_file="${OUTPUT_DIR}/wayback_$(echo "${target}" | sed 's/[^[:alnum:]]/_/g')_${start_year}_$(date +%Y).txt"
    waybackurls "${target}" -d "${start_year}",$(date +%Y) | sort -u > "${output_file}"
}


# Check if the user wants to perform waybackurls on the given target URL or the alive domains
read -p $'\e[1;36mDo you want to perform waybackurls on the target URL or on the alive domains? (target/alive): \e[0m' wayback_option

if [[ "${wayback_option}" == "target" ]]; then
    # Perform waybackurls on the given target URL
    perform_waybackurls "${target}"
else
    # Perform waybackurls on the URLs from the ALIVE_DOMAINS_FILE
    mapfile -t alive_domains < "${ALIVE_DOMAINS_FILE}"
    for domain in "${alive_domains[@]}"; do
        perform_waybackurls "${domain}"
    done
fi


# Merge all crawled files and remove duplicates
merged_file="${OUTPUT_DIR}/wayback_merged_$(echo "${target}" | sed 's/[^[:alnum:]]/_/g').txt"
cat "${OUTPUT_DIR}/wayback_"*"_$(date +%Y).txt" | sort -u > "${merged_file}"

# Extract JS URLs
grep -E '\.js(\?|$)' "${merged_file}" > "${JS_URLS_FILE}"

# Extract URLs containing "=, ?, @, #, &"
grep -E '[=&?@#]' "${merged_file}" > "${VULNERABLE_URLS_FILE}"

# Save the unique URLs as finalUrls.txt
mv "${merged_file}" "${FINAL_URLS_FILE}"

# Remove individual crawled files
rm "${OUTPUT_DIR}/wayback_"*"_$(date +%Y).txt"

print_color_text "\e[1;36m" "Wayback Machine crawling process completed."
print_color_text "\e[1;33m" "Unique URLs saved as ${FINAL_URLS_FILE}."
print_color_text "\e[1;33m" "JS URLs saved as ${JS_URLS_FILE}."
print_color_text "\e[1;33m" "Potential Vulnerable URLs saved as ${VULNERABLE_URLS_FILE}."
print_color_text "\e[1;33m" "SubDomains URLs saved as ${SUBDOMAINS_FILE}."
print_color_text "\e[1;33m" "AliveDomain URLs saved as ${ALIVE_DOMAINS_FILE}."

print_color_text "\e[1;36m" "Checking vulnerable URLs for XSS..."

# Array to store processed URLs
processed_urls=()

# Replace payload in URLs and filter vulnerable URLs
while IFS= read -r url; do
    vulnerable_url=$(echo "${url}" | qsreplace "${xss_payload}")
    if ! [[ "${processed_urls[*]}" =~ "${vulnerable_url}" ]]; then
        processed_urls+=("${vulnerable_url}")
        response=$(curl -s -L "${vulnerable_url}")
        if [[ "${response}" == *"${xss_payload}"* ]]; then
            echo -e "\e[1;91m${url}\e[0m" >> "${XSS_VULNERABLE_URLS_FILE}"
            echo -e "\e[1;91m${url}\e[0m"
        fi
    fi
done < "${VULNERABLE_URLS_FILE}"

print_color_text "\e[1;33m" "Vulnerability check completed."

if [[ -s "${XSS_VULNERABLE_URLS_FILE}" ]]; then
    print_color_text "\e[1;91m" "Vulnerable URLs for XSS:"
    cat "${XSS_VULNERABLE_URLS_FILE}"
    print_color_text "\e[1;91m" "Vulnerable URLs saved as ${XSS_VULNERABLE_URLS_FILE}"
else
    print_color_text "\e[1;33m" "No vulnerable URLs found for XSS."
    print_color_text "\e[1;36m" "No vulnerable URLs saved."
fi

print_color_text "\e[1;32m" "AutoRecon XSS completed successfully!"
