FROM ubuntu:latest
MAINTAINER Deven Phillips <deven.phillips@gmail.com>

RUN apt-get update && apt-get -y install unzip curl openjdk-7-jre-headless supervisor && rm -rf /var/cache/apt
RUN cd /tmp && curl -L -O http://dist.sonar.codehaus.org/sonarqube-5.1.2.zip && unzip sonarqube-5.1.2.zip && mv sonarqube-5.1.2 /opt/sonar
RUN sed -i 's|wrapper.daemonize=TRUE|wrapper.daemonize=FALSE|g' /opt/sonar/bin/linux-x86-64/sonar.sh

ADD sonarqube.conf /etc/supervisor/conf.d/sonarqube.conf

EXPOSE 9000
VOLUME /data

ADD start /usr/bin/start
RUN chmod 755 /usr/bin/start
ADD restart /usr/bin/restart
RUN chmod 755 /usr/bin/restart

CMD ['/usr/bin/start', '/usr/bin/restart']
