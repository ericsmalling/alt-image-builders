# Java Dockerfile vs. Jib example
Comparison of building a Java application container with Dockerfile vs. Jib

This repo is based on the `helloworld` example from the https://github.com/GoogleContainerTools/jib repo to demonstrate a Maven based setup with labels

---
## Required software
* Java
* Maven
* Docker

---
## Build image via Dockerfile
1. Build the .jar file: `mvn clean package`
2. Test it:
```
$ java -jar target/helloworld-1.2.3.jar
Hello world
```
3. Build the image (replace `${your_registry}` accordingly):
```
$ docker build -t ${your_registry}/helloworld:1.2.3 .
[+] Building 0.4s (7/7) FINISHED
...
=> exporting to image
=> => exporting layers
=> => writing image sha256:367ae5e92128441c5c2e64ecaa36cd0b8f4e51cfe
=> => naming to ${your_registry}/helloworld:1.2.3
```
4. If your image registry requires authentication, authenticate to it (example shows DockerHub):
```
$ docker login
Username: your_user
Password: *********
Login Succeeded
```
5. Push image to registry:
```
$ docker push ${your_registry}/helloworld:1.2.3
The push refers to repository [${your_registry}/helloworld]
3a808f9fbf5e: Pushed
14cae1d60035: Mounted from library/eclipse-temurin
7806a5d290f3: Mounted from library/eclipse-temurin
ce70b3f4ba58: Mounted from library/eclipse-temurin
b2d57f066f0d: Mounted from library/eclipse-temurin
1: digest: sha256:ae0681ceeeb47d871c95b21b427d25f8bb3ab896df48810305014dedbdd8c9d2 size: 1372
```
6. Run the container:
```
$ docker run --rm -it ${your_registry}/helloworld:1.2.3
Hello world
```
---
## Build image via jib
Note: None of the steps in this section require Docker to be installed.
1. In `pom-jib.xml` replace `image-registry` property with your registry (and account if applicable) or use a `-D` parameter as shown below

2. If needed, add registry credentials via instructions at https://github.com/GoogleContainerTools/jib/tree/master/jib-maven-plugin#authentication-methods

3. Run `mvn package` with an optional `-D image-registry=${your_registry}` as needed if you didn't update that property in the `pom.xml` above.

```
$ mvn clean package -D image-registry=${your_registry} -f pom-jib.xml
[INFO] Scanning for projects...
[INFO]
[INFO] -------------------------< example:helloworld >-------------------------
[INFO] Building helloworld 1.2.3
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
...
[INFO] --- jib-maven-plugin:3.2.1:build (default) @ helloworld ---
[INFO]
[INFO] Containerizing application to ${your_registry}/helloworld:jib-1.2.3...
...
[INFO] Using base image with digest: sha256:c5916c77fc7f643b8afe4fd8cc4e7a5ee102f1c6ba502b967edcce32b2abe618
[INFO]
[INFO] Container entrypoint set to [java, -cp, /app/resources:/app/classes:/app/libs/*, example.HelloWorld]
[INFO]
[INFO] Built and pushed image as ${your_registry}/helloworld:jib-1.2.3
[INFO] Executing tasks:
[INFO] [==============================] 100.0% complete
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  5.170 s
[INFO] Finished at: 2022-08-18T12:28:10-05:00
[INFO] ------------------------------------------------------------------------
```

4. Run the container:
```
$ docker run --rm -it ${your_registry}/helloworld:jib-1.2.3
Hello world
```