############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu which spports long term support(LTS version)
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Plato Puthur

RUN apt-get update
RUN apt-get upgrade -y

# Install Nginx

RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Install necessary tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y  nano wget dialog net-tools

RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Download and Install Nginx
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx

#delete the Default file in sites-avaialble
RUN rm /etc/nginx/sites-available/default

#copy our application configuration files and create links
ADD dev.techtuft.app /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 83

# Set the default command to execute
# when creating a new container
CMD service nginx start
