FROM centos AS build
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /opt
WORKDIR /opt
RUN tar -zxvf apache-maven-3.8.6-bin.tar.gz
RUN mv apache-maven-3.8.6 maven38
WORKDIR /opt/maven38/bin/mvn clean package
COPY . .

FROM tomcat:8.5.43-jdk8
COPY --from=build /var/lib/jenkins/worksapce/target/*.war /usr/local/tomcat/webapps
