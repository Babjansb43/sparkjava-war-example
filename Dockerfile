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


FROM ubuntu
RUN apt install default-jdk -y
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz /opt
RUN tar -zxvf apache-tomcat-9.0.68.tar.gz && rm -rf apache-tomcat-9.0.68.tar.gz
RUN mv apache-tomcat-9.0.68 tomcat9
RUN chmod 755 /opt/tomcat9/bin/*.sh
COPY --from=build /app/source/target/*.war /opt/tomcat9/webapps
CMD ["/opt/tomcat9/bin/catalina.sh", "run"]