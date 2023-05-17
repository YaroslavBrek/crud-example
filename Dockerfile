FROM maven:3-jdk-8-alpine AS build
ADD pom.xml /dmaven/
ADD src/ /dmaven/src/
WORKDIR /dmaven
RUN mvn -f pom.xml clean package


FROM tomcat:9.0.65-jre11-openjdk
COPY --from=build dmaven/target/mvcspringproject.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8181
EXPOSE 3306
CMD ["catalina.sh", "run"]

