FROM  frolvlad/alpine-oraclejdk8:cleaned
MAINTAINER Anze Cesar <anze.cesar@gmail.com>

RUN apk update
RUN apk add bash

ENV SBT_VERSION 0.13.8
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# Install sbt
RUN wget -qO- "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x -C /usr/local

ADD scala.sbt /tmp/scala.sbt
WORKDIR /tmp
RUN sbt compile
