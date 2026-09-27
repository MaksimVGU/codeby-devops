FROM eclipse-temurin:21-jre
WORKDIR /app
COPY target/hello-world-1.0.0.jar app.jar
ENTRYPOINT ["java","-cp","/app/app.jar","ru.lesson26.helloworld.App"]
