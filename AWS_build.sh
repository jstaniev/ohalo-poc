#!/bin/bash

IMAGE_ID="ami-0c02fb55956c7d316"
INST_TYPE="t3.medium"
KEY_NAME="oroborus"
SG_NAME="ohalo_poc-sg"

aws ec2 create-security-group --group-name $SG_NAME --description "Ohalo POC SG"
aws ec2 authorize-security-group-ingress --group-name $SG_NAME --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $SG_NAME --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $SG_NAME --protocol tcp --port 443 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-name $SG_NAME --protocol tcp --port 17419 --cidr 0.0.0.0/0
SG_ID="$(aws ec2 describe-security-groups --group-names $SG_NAME --query 'SecurityGroups[].GroupId' --output text)"

aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type $INST_TYPE	--key-name $KEY_NAME \
	--security-group-ids $SG_ID --user-data file://ec2_user_data --instance-market-options '{"MarketType":"spot"}' \
	--block-device-mapping DeviceName=/dev/xvda,Ebs={VolumeSize=20}

INST_ID=$(aws ec2 describe-instances --filters "Name=instance-type,Values=$INST_TYPE" --query 'Reservations[].Instances[].InstanceId' --output text)
IP=$(aws ec2 describe-instances --instance-ids $INST_ID --query 'Reservations[*].Instances[*].PublicIpAddress' --output text)

function hurryup () {
    until ssh -o ConnectTimeout=2 "$1"@"$2" echo ALIVE
        do sleep 1
    done
}

ssh-keyscan $IP >> ~/.ssh/known_hosts
hurryup ec2-user $IP

echo "Docker host ready at $IP\r"
export DOCKER_HOST=ssh://root@$IP
echo "DOCKER_HOST=ssh://root@$IP configured"
docker ps -a
