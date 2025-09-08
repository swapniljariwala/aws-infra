#!/bin/bash

# Variables
echo "[$(date)] Cron triggered" >> /var/log/update-route53.log
PATH=/usr/local/bin:/usr/bin:/bin

INSTANCE_ID="i-04da0e062ec60597d"
HOSTED_ZONE_ID="Z00326323L8S94T2OIJHQ"
RECORD_NAME="content-gen.marketsetup.in"
# Get current public IP of the instance
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --output text)

if [[ -z "$PUBLIC_IP" || "$PUBLIC_IP" == "None" ]]; then
    echo "Failed to fetch public IP for instance $INSTANCE_ID"
    exit 1
fi

# Create JSON payload for Route 53
CHANGE_BATCH=$(cat <<EOF
{
  "Comment": "Update A record for $RECORD_NAME",
  "Changes": [{
    "Action": "UPSERT",
    "ResourceRecordSet": {
      "Name": "$RECORD_NAME",
      "Type": "A",
      "TTL": 60,
      "ResourceRecords": [{ "Value": "$PUBLIC_IP" }]
    }
  }]
}
EOF
)

# Update Route 53 record
aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE_ID \
    --change-batch "$CHANGE_BATCH"

if [[ $? -eq 0 ]]; then
    echo "Successfully updated $RECORD_NAME to $PUBLIC_IP"
else
    echo "Failed to update DNS record"
    exit 1
fi

