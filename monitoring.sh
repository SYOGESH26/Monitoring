#!/bin/bash

# Correct variable assignments (NO SPACES!)
cpu_threshold=50
mem_threshold=6
df_threshold=7
mail="siddapati.yogesh26@gmail.com"
logs="/var/log/system_monitoring.log"
date=$(date '+%Y-%m-%d %H:%M:%S')

# Create log file and directory if not exist
sudo mkdir -p /var/log
touch $logs

# Log function
log() {
    echo "[$date] $1" >> "$logs"
}

# Check CPU Usage
check_cpu() {
    CPU_LOAD=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
    CPU_LOAD_INT=${CPU_LOAD%.*}
    log "CPU Load: $CPU_LOAD%"
    if [ "$CPU_LOAD_INT" -ge "$cpu_threshold" ]; then
        echo "ALERT: High CPU usage: $CPU_LOAD%" | mail -s "High CPU Alert" "$mail"
    fi

    log "Top 5 CPU-consuming processes:"
    top -b -o +%CPU -n1 | head -n 12 | tail -n 5 >> "$logs"
}

# Check Memory
check_memory() {
    MEM_USED=$(free -m | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100.0}')
    MEM_INT=${MEM_USED%.*}
    log "Memory Usage: $MEM_USED%"
    if [ "$MEM_INT" -ge "$mem_threshold" ]; then
        echo "ALERT: High Memory usage: $MEM_USED%" | mail -s "High Memory Alert" "$mail"
    fi

    log "Top 5 Memory-consuming processes:"
    ps aux --sort=-%mem | head -n 6 >> "$logs"
}

# Check Disk
check_disk() {
    log "Disk Usage:"
    df -h >> "$logs"

    DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$DISK" -ge "$df_threshold" ]; then
        echo "ALERT: Disk usage on / is $DISK%" | mail -s "High Disk Alert" "$mail"
    fi
}

# Monitor Network
monitor_network() {
    log "IP Address:"
    ip a | grep inet | grep -v 127.0.0.1 >> "$logs"

    log "Default Gateway:"
    ip route | grep default >> "$logs"

    log "Active Connections (TCP):"
    ss -tuna | grep ESTAB | wc -l >> "$logs"

    log "Latency to Google (ping test):"
    ping -c 4 8.8.8.8 >> "$logs"
}

# Uptime
monitor_uptime_load() {
    log "System Uptime and Load:"
    uptime >> "$logs"
}

# Swap usage
monitor_swap() {
    log "Swap Usage:"
    free -m | grep Swap >> "$logs"
}

# Header in log
{
echo "============================="
echo "Monitor Run at: $date"
echo "============================="
} >> "$logs"

# Run all checks
check_cpu
check_memory
check_disk
monitor_network
monitor_uptime_load
monitor_swap

log "Monitoring completed."

