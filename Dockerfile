# Build stage
# Build context must be ./back (set in docker-compose.yml)
FROM eclipse-temurin:21-jdk AS build

WORKDIR /build

RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Install parent POM to local Maven repository
COPY financial-app-parent/pom.xml financial-app-parent/pom.xml
RUN mvn -f financial-app-parent/pom.xml install -N -q

# Resolve dependencies (cached layer — only re-runs when pom.xml changes)
COPY ms-cards/pom.xml ms-cards/pom.xml
RUN mvn -f ms-cards/pom.xml dependency:go-offline -q

# Build
COPY ms-cards/src ms-cards/src
RUN mvn -f ms-cards/pom.xml clean package -DskipTests -q

# Runtime stage
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /build/ms-cards/target/*.jar app.jar

EXPOSE 8083

ENTRYPOINT ["java", "-jar", "app.jar"]
