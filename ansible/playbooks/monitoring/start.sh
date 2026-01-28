#!/bin/bash

set -m

setsid /usr/local/bin/victoria-metrics-prod -storageDataPath=/var/lib/victoria-metrics -retentionPeriod=90d -selfScrapeInterval=10s < /dev/null > /var/log/victoriametrics.log 2>1 &

setsid /usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yaml < /dev/null > /var/log/prometheus.log 2>&1 &

