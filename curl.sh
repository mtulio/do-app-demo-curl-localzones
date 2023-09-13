#!/usr/bin/env bash

echo \"# Client Location: \"
curl -s http://ip-api.com/json/\$(curl -s ifconfig.me) |jq -r '[.city, .countryCode]'

run_curl() {
  echo -e \"time_namelookup\\t time_connect \\t time_starttransfer \\t time_total\"
  for idx in \$(seq 1 5); do
    curl -sw \"%{time_namelookup} \\t %{time_connect} \\t %{time_starttransfer} \\t\\t %{time_total}\\n\" \
    -o /dev/null -H \"Host: \$1\" \${2:-\$1}
  done
}

echo -e \"\n# Collecting request times to server running in AZs/Regular zones [endpoint ${APP_HOST_AZ}]\"
run_curl ${APP_HOST_AZ}

echo -e \"\n# Collecting request times to server running in Local Zone NYC [endpoint ${APP_HOST_NYC}]\"
run_curl ${APP_HOST_NYC}

echo -e \"\n# Collecting request times to server running in Local Zone BUE [endpoint ${APP_HOST_BUE}]\"
run_curl ${APP_HOST_BUE} ${IP_HOST_BUE}