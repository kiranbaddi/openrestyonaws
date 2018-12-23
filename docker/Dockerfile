# Docker File to create openresty.

FROM ubuntu:latest

# Update repos and install dependencies to install openresty 
RUN sudo apt-get update && \\
    sudo apt-get install libssl1.0.0 libfindbin-libs-perl -y

# Make folders for logs and config files

RUN mkdir -p /openresty-demo/logs && \\
    mkdir -p /openresty-demo/conf
WORKDIR /demo

#Copy debian packag to temp folder on the container

COPY *.deb /tmp

#Copy nginix config files to the container
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for webserver 

EXPOSE 80

# Install openresty from the .deb pakcage created
RUN dpkg -i /tmp/*.deb


# Add Opernresty folder to PATH
ENV PATH=$PATH:/usr/local/openresty/luajit/bin/:/usr/local/openresty/nginx/sbin/:/usr/local/openresty/bin/

#Start openresty once the contatiner is instantiated

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]

