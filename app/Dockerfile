FROM ubuntu
RUN apt-get -y update
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN apt-get -y install git openjdk-11-jre-headless wget xz-utils
RUN wget https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz
RUN mkdir -p /usr/local/lib/nodejs
RUN tar -xJvf node-v16.14.2-linux-x64.tar.xz -C /usr/local/lib/nodejs
ENV PATH=/usr/local/lib/nodejs/node-v16.14.2-linux-x64/bin:$PATH
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS
ENV JHIPSTER_SLEEP=0
RUN git clone https://github.com/jstaniev/ohalo-jhipster-sample.git
WORKDIR ohalo-jhipster-sample/
RUN npm install
RUN ./gradlew -Pprod clean bootJar
ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
#RUN ./gradlew -x webapp
EXPOSE 8080
#CMD ["java", "-Xmx512m", "-Xms256m", "-noverify", "-XX:+AlwaysPreTouch", "-Djava.security.egd=file:/dev/./urandom", "-jar build/libs/sample-app-0.0.1-SNAPSHOT.jar"]
#CMD ["java", "-jar", "build/libs/*.jar"]
ENTRYPOINT ["/entrypoint.sh"]
#CMD ["npm", "start"]

