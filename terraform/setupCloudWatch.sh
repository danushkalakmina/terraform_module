#!/bin/bash


aws elasticache modify-replication-group \
    --replication-group-id ${ClusterName} \
    --apply-immediately \
    --log-delivery-configurations '
    {
      "LogType":"slow-log", 
      "DestinationType":"cloudwatch-logs", 
      "DestinationDetails":{ 
        "CloudWatchLogsDetails":{ 

          "LogGroup":"${LogGroupName}"
        } 
      },
      "LogFormat":"json" 
    }'