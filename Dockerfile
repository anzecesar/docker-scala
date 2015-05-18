FROM phusion/baseimage:0.9.16
MAINTAINER Anze Cesar <anze.cesar@gmail.com>

CMD ["/sbin/my_init"]

# Create a build user & group
RUN groupadd -r build && useradd -r -m --home /home/build -g build build

# Add sbt's bintray repo
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list

# Install dependencies
RUN apt-get update && apt-get install -y --force-yes openjdk-7-jre-headless sbt=0.13.8

# Cleanup Apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch sbt dependencies
USER build
ADD scala.sbt /tmp/scala.sbt
WORKDIR /tmp
RUN sbt compile