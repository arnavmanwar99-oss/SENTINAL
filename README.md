# SENTINAL --- Security Log Analyzer

SENTINAL is a beginner-friendly cybersecurity project built with **Bash,
AWK, and Linux command-line tools**. It scans log files, looks for
entries containing selected suspicious keywords, counts IP-address
occurrences in matching lines, and prints a terminal report.

> **Note:** SENTINAL is a learning project. Its alerts indicate patterns
> worth investigating; they do not prove that an attack has occurred.

## Features

-   Finds files ending in `.logs` in the current directory and its
    subdirectories.
-   Reports the total number of log lines and files evaluated.
-   Searches log entries for keywords such as `failed`, `error`, `warn`,
    `denied`, `drop`, and `401`.
-   Extracts IPv4-looking values from matching lines, including values
    in fields such as `client_ip=192.0.2.44`.
-   Counts occurrences of each extracted IP address within each file.
-   Assigns severity levels using configurable occurrence thresholds:
    -   **MEDIUM:** 3--4 occurrences
    -   **HIGH:** 5 or more occurrences
-   Prints matching log entries in an "Essential Logs" section.

## Log types used for testing

SENTINAL can be tested with sample files such as:

-   `auth.logs` --- authentication events
-   `system.logs` --- system events
-   `firewall.logs` --- firewall events
-   `application.logs` --- application events
-   `network.logs` --- network connection records

The script searches all discovered `.logs` files, but its keyword-based
detection works best when the log entries contain one of the configured
keywords. Network records that do not contain those keywords may not
appear in the "Essential Logs" output.

## Requirements

-   Linux
-   Bash
-   AWK
-   `grep`
-   Standard command-line utilities such as `find` and `wc`

## Getting started

1.  Clone or download this repository.
2.  Open a terminal and change into the project directory.
3.  Ensure your sample `.logs` files are in the project directory or one
    of its subdirectories.
4.  Make the script executable and run it:

``` bash
chmod +x Analyse.sh
./Analyse.sh
```

You can also run it with:

``` bash
bash Analyse.sh
```

Run the script from the directory where you want it to discover `.logs`
files.

## How detection works

1.  The script discovers files with the `.logs` extension.
2.  It counts the total lines and number of files found.
3.  For each file, AWK checks lines containing configured keywords,
    ignoring keyword capitalization.
4.  It extracts fields that look like IPv4 addresses and counts their
    occurrences.
5.  It reports IPs that meet the MEDIUM or HIGH thresholds.
6.  `grep` prints matching entries for review.

## Important limitations

-   **Keyword matching is simple:** Relevant activity may be missed if
    it does not contain one of the configured keywords.
-   **An IP count is not proof of an attack:** The script counts IP
    appearances on matching lines, not confirmed malicious actions.
-   **Source and destination IPs are not distinguished:** If a matching
    line contains both, both may be counted.
-   **Thresholds are basic:** The MEDIUM and HIGH levels are based on
    occurrence counts and are not a calibrated risk score.
-   **Log formats vary:** Different systems use different formats, so
    detection accuracy depends on the structure of the logs.
-   **Network logs may need separate rules:** Ordinary connection
    records may not contain the current search keywords.

Use fictional or sanitized logs for testing. Do not publish real logs
containing usernames, public or private infrastructure details, tokens,
passwords, or other sensitive information.

## What I learned

Building SENTINAL provided hands-on practice with:

-   Bash scripting, loops, variables, and command substitution
-   AWK fields, loops, associative arrays, and regular expressions
-   Searching log files with `grep`
-   Extracting and counting IPv4 addresses
-   Creating a command-line report
-   Debugging and improving a small security-analysis workflow

## Future improvements

-   Distinguish source IP addresses from destination IP addresses.
-   Add detection rules tailored to each log format.
-   Improve network-log analysis.
-   Reduce false positives and make alert thresholds configurable.
-   Export reports to a structured format such as CSV or JSON.
-   Add automated tests using sample logs.

## Project status

A first working version built as a hands-on learning project.
Contributions, suggestions, and feedback are welcome.
