# ---- 构建阶段 ----
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# 1. 复制所有模块的 pom.xml，利用 Docker 缓存加速
COPY pom.xml .
COPY sky-common/pom.xml ./sky-common/
COPY sky-pojo/pom.xml ./sky-pojo/
COPY sky-server/pom.xml ./sky-server/

# 2. 提前下载依赖
RUN mvn dependency:go-offline -B

# 3. 复制所有的 src 源码目录
COPY sky-common/src ./sky-common/src
COPY sky-pojo/src ./sky-pojo/src
COPY sky-server/src ./sky-server/src

# 4. 执行 Maven 打包
RUN mvn clean package -DskipTests

# ---- 运行阶段 ----
FROM eclipse-temurin:11-jre
WORKDIR /app

# 5. 只复制打包好的可执行 jar 包（启动类在 sky-server 里）
COPY --from=build /app/sky-server/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]