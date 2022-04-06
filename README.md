# ohalo-poc

 - __AWS_deploy.sh__ : This is a shell script that deploys an AWS EC2 t3.medium instance, installs Docker, and reports back its IP address. It requires AWS CLI credentials and a default region to be configured via awsconfig.
 - __ec2_user_data__ : This is a flat text file containing provisioning configuration for the Docker host on AWS EC2.
 - __deploy.yml__ : This is a YAML document that can be run with docker-compose to deploy several containers on a Docker host. It will deploy a MySQL database container, a Nginx reverse proxy container, and two OpenJDK11 Java application containers.
 - __proxy/__ : This directory contains the Docker build configuration for the Nginx reverse proxy.
 - __app/__ : This directory contains the Docker build configuration for the sample JHipster application.
