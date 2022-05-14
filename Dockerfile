#FROM maven:3.6.3-jdk-11-openj9 AS build 
#COPY estore-legacy/src /usr/src/app/src  
#COPY estore-legacy/pom.xml /usr/src/app
#RUN mvn -f /usr/src/app/pom.xml clean package
 
# Pull base container image from Microsoft container registry.
FROM mcr.microsoft.com/java/tomcat:11-zulu-ubuntu-tomcat-9

# Add groups/users.
RUN groupadd -r -f -g 1001 tomcat
RUN useradd -r -g 1001 -u 1001 tomcat

# Copy application folders into the container.
#COPY --from=build /usr/src/app/target/estore-legacy.war /usr/local/tomcat/webapps/
#COPY ["./target/sample.war", "/usr/local/tomcat/webapps/"]
#COPY ["./conf/server.xml", "/usr/local/tomcat/conf/server.xml"]
#COPY ["./MandatoryArtifacts/lib", "/usr/local/tomcat/lib/"]
RUN chown -R tomcat:tomcat /usr/local/tomcat

# Assign user context to run the container.
COPY --chown=tomcat:tomcat ./Entryscript.sh /Entryscript.sh
USER tomcat:tomcat
RUN chmod +x /Entryscript.sh
ENTRYPOINT /Entryscript.sh
EXPOSE 8080
