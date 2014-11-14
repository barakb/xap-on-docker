FROM ubuntu

#Replace dash with bash

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

MAINTAINER Barak Bar Orion <barak.bar@gmail.com>

# Install Java.

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -y oracle-java8-installer ca-certificates


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

WORKDIR /data

#Install Unzip
RUN apt-get install -y unzip

RUN apt-get install -y vim

RUN apt-get install -y iptables


#Install Xap
ADD gigaspaces-xap-premium-10.1.0-m6-b12586-99.zip /data/xap.zip
RUN unzip xap.zip && rm -f xap.zip

RUN p=`find /data/ -type d -name bin | awk '{ print length, $0 }' | sort -n | cut -d" " -f2- | head -1` && gigadir=${p//bin/} && mv $gigadir xap
#RUN find /data/ -type d -name bin >> /data/find.txt
#RUN mkdir xap

RUN rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk8-installer

WORKDIR /data/xap/bin

ADD xap.sh /data/xap/bin/xap.sh

CMD ["bash"]

