# Use the specified base image from Docker Hub
FROM 2stacks/vyos:1.2.0-rc11

# Modify vyos-router script to remove 'nr_inodes' setting
RUN sed -i s,"nr_inodes","",g /usr/libexec/vyos/init/vyos-router

# Set the terminal type environment variable
RUN echo "export TERM=xterm" >> /etc/skel/.bashrc

# Create necessary directories and files, set permissions and group
RUN mkdir -p /var/log/vyatta/ && \
    touch /var/log/vyatta/vyatta-config-loader.log && \
    touch /var/log/vyatta/vyatta-commit.log && \
    chmod ugo+rwX /var/log/vyatta/ && \
    chgrp -R vyattacfg /var/log/vyatta/

# Add initial configuration file
ADD config.init /config.init

# Create and set up the vyos-config script
RUN echo "#!/bin/bash" > /usr/libexec/vyos/init/vyos-config && \
    echo "source /opt/vyatta/etc/functions/script-template" >>  /usr/libexec/vyos/init/vyos-config && \
    echo "sg vyattacfg -c '/opt/vyatta/sbin/vyatta-boot-config-loader /config.init'" >> /usr/libexec/vyos/init/vyos-config

# Copy the vyos_routes.sh script into the container
COPY /vyos_routes.sh /vyos_routes.sh

# Set the entrypoint to init
ENTRYPOINT ["/sbin/init"]

