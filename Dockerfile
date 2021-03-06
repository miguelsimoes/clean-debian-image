FROM debian:jessie
LABEL maintainer="Miguel Simões <msimoes@gmail.com>"
#
# Ensure that the server has the correct timezone installed
RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
#
# Ensure that the machine is always built with the most recent versions
# and removing all non required artifacts to minimize the image size
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qqq
#
# Before we make the upgrade we will add a new repository, so we need the
# wget package to retrieve the GPG key for it
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https apt-utils
#
# Let us ensure that the TERM is always set when we initialize the container
ENV TERM xterm
#
# And we continue the normal process to update the system
RUN DEBIAN_FRONTEND=noninteractive apt-get update -y -qqq
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qqq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qqq nano
RUN DEBIAN_FRONTEND=noninteractive apt-get purge eject modemmanager -y -qqq
RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -y -qqq
RUN DEBIAN_FRONTEND=noninteractive apt-get clean -y -qqq
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean -y -qqq
#
# Remove all non-required information from the system to have the smallest
# image size as possible
RUN rm -rf /usr/share/doc/* /usr/share/man/?? /usr/share/man/??_* /usr/share/locale/* /var/cache/debconf/*-old /var/lib/apt/lists/*
