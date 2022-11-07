FROM ubuntu AS build
RUN mkdir -p /app/source
COPY . /app/source
RUN apt update -y && RUN apt install default-jdk -y
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /opt
WORKDIR /opt
RUN tar -zxvf apache-maven-3.8.6-bin.tar.gz && RUN mv apache-maven-3.8.6 maven38
WORKDIR /app/source
RUN /opt/maven38/bin/mvn clean package


FROM centos
ENV PATH=$PATH:/opt/java/jdk-15.0.2/bin
WORKDIR /opt/java
RUN curl https://download.java.net/java/GA/jdk15.0.2/0d1cfde4252546c6931946de8db48ee2/7/GPL/openjdk-15.0.2_linux-x64_bin.tar.gz -o openjdk-15.0.2_linux-x64_bin.tar.gz
RUN tar -xzf openjdk-15.0.2_linux-x64_bin.tar.gz && rm -rf openjdk-15.0.2_linux-x64_bin.tar.gz
WORKDIR /opt
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz /opt
RUN tar -zxvf apache-tomcat-9.0.68.tar.gz && rm -rf apache-tomcat-9.0.68.tar.gz && RUN mv apache-tomcat-9.0.68 tomcat9 && RUN chmod 755 /opt/tomcat9/bin/*.sh
COPY --from=build /app/source/target/*.war /opt/tomcat9/webapps
CMD ["/opt/tomcat9/bin/catalina.sh", "run"]