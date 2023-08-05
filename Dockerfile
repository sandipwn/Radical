FROM tomcat:9.0.52-jre11-openjdk-slim
COPY ./target/radical*.jar /usr/local/tomcat/webapps
EXPOSE 8080
WORKDIR /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]