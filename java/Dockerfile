FROM eclipse-temurin:8
COPY target/helloworld-1.2.3.jar /helloworld.jar

LABEL "org.opencontainers.image.source"="https://github.com/ericsmalling/alt-image-builders"
CMD ["java", "-jar", "/helloworld.jar"]

