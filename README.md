
# Monitoring

## **Overview**

This is a **Bash-based system monitoring script** for Linux systems. It tracks system health by checking **CPU usage**, **memory usage**, **disk usage**, **network status**, **uptime**, and **swap memory**. Alerts are sent via email when thresholds are exceeded, and detailed logs are maintained in `/var/log/system_monitoring.log`.

# -------------------------------------------------------------------

## **Features**

* CPU usage monitoring with top 5 CPU-consuming processes logged.
* Memory usage monitoring with top 5 memory-consuming processes logged.
* Disk usage monitoring with alert if usage exceeds threshold.
* Network monitoring:
  * IP addresses
  * Default gateway
  * Active TCP connections
  * Latency via ping to Google DNS
* System uptime and load logging.
* Swap memory usage logging.
* Email notifications for thresholds exceeded.
* Logs stored at `/var/log/system_monitoring.log`.
# ------------------------------------------------------------------

## **Requirements**

* Linux OS
* Bash shell
* `mail` command configured for sending email alerts
* `top`, `ps`, `df`, `ip`, `ss`, `ping`, `free` commands available (default in most Linux distros)
# -----------------------------------------------------------------

# Usage

1. Make the script executable:
   chmod +x system_monitoring.sh
2. Run the script manually:
   sudo ./system_monitoring.sh
3. Example log output location:
    /var/log/system_monitoring.log
4. Email alerts will be sent to the address specified in the script:
   mail="siddapati.yogesh26@gmail.com"
# -------------------------------------------------------------
# Configuration

* CPU Threshold (`cpu_threshold`) — default: `50%`
* Memory Threshold (`mem_threshold`) — default: `6%`
* Disk Threshold (`df_threshold`) — default: `7%`
* Email (`mail`) — specify your email for receiving alerts.
* Log File (`logs`) — default: `/var/log/system_monitoring.log`
> * Note: Thresholds can be adjusted by editing the variable values at the top of the script.
# ---------------------------------------------------------
* Logging
All monitored information is appended to:
/var/log/system_monitoring.log

