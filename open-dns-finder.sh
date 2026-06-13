DOMAIN="YOUR_NS_RECORD_ADDRESS"; \
TARGET_IP="YOUR_A_RECORD_IP_ADDRESS"; \
INPUT_FILE="ips.txt"; \
OUTPUT_FILE="sorted_dns.txt"; \
TEMP_FILE="result_temp.txt"; \
\
rm -f $TEMP_FILE; \
echo "Starting DNS Benchmark..."; \
echo "Testing servers against domain: $DOMAIN"; \
echo "Target IP to match: $TARGET_IP"; \
echo "--------------------------------------------"; \
\
while read ip; do \
    ( \
    # Extract query time using dig
    RES=$(dig @$ip $DOMAIN +time=1 +tries=1)
    # Check if the response contains the Target IP
    if echo "$RES" | grep -q "$TARGET_IP"; then
        TIME=$(echo "$RES" | grep "Query time" | awk '{print $4}')
        echo "$TIME $ip" >> $TEMP_FILE
        echo "[MATCH]   $ip | Response Time: $TIME ms | Contains: $TARGET_IP"
    else
        echo "[IGNORE]  $ip | Target IP not found in response"
    fi \
    ) & \
done < $INPUT_FILE; \
\
wait; \
\
# Sorting by speed (column 1) and formatting the output
echo -e "\n--------------------------------------------"; \
echo "Benchmark Complete!"; \
echo "Ranking (Fastest to Slowest):"; \
echo "Latency | IP Address"; \
echo "--------------------"; \
sort -n $TEMP_FILE | awk '{printf "%-7s | %s\n", $1 "ms", $2}' > $OUTPUT_FILE; \
rm $TEMP_FILE; \
cat $OUTPUT_FILE; \
echo "--------------------------------------------"; \
echo "Results saved to: $OUTPUT_FILE"