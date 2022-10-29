FROM centos AS build
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /opt
RUN mv apache-maven-3.8.6-bin.tar.gz /opt/maven
WORKDIR /opt/maven/bin/mvn clean package

FROM tomcat
COPY --from=build /var/lib/jenkins/worksapce/target/*.war /usr/local/tomcat/webapps
