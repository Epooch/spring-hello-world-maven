FROM amazoncorretto:17-alpine-jdk as application-builder
#copy project
RUN mkdir /project
COPY . /project
RUN apk add maven
#get project and package it up
WORKDIR /project
RUN mvn clean package

FROM amazoncorretto:17-alpine-jdk as application-runner
COPY --from=application-builder /project/target/colosseo-api-toolbelt-0.0.1-SNAPSHOT.jar /project/target/colosseo-api-toolbelt-0.0.1-SNAPSHOT.jar
EXPOSE 8080
CMD ["java","-jar","/project/target/colosseo-api-toolbelt-0.0.1-SNAPSHOT.jar"]