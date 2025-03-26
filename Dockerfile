FROM eclipse-temurin:21
ARG VERSION=v1.3.0-beta
WORKDIR /opt/app
ADD https://github.com/GlobalDataverseCommunityConsortium/dataverse-uploader/releases/download/$VERSION/DVUploader-$VERSION.jar DVUploader.jar
ENTRYPOINT ["java", "-jar", "DVUploader.jar"]
