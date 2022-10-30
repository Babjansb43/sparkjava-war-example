FROM ubuntu AS build
RUN mkdir -p /app/source
COPY . /app/source
RUN apt update -y
RUN apt install default-jdk -y
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /opt
WORKDIR /opt
RUN tar -zxvf apache-maven-3.8.6-bin.tar.gz
RUN mv apache-maven-3.8.6 maven38
WORKDIR /app/source
RUN /opt/maven38/bin/mvn clean package


FROM tomcat
COPY --from=build /app/source/target/*.war /usr/local/tomcat/webapps
