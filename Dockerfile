# ใช้ OpenJDK 16 บน Alpine Linux เป็น Base Image
FROM openjdk:16-jdk-alpine

# สร้างกลุ่มและผู้ใช้สำหรับรัน Spring Boot
RUN addgroup -S spring && adduser -S spring -G spring

# กำหนดให้เปิดพอร์ต 8080
EXPOSE 8080

# ตั้งค่า Spring Profile ให้เป็น "prod" ตามค่าเริ่มต้น
ENV JAVA_PROFILE=prod

# กำหนดโฟลเดอร์ที่เก็บ Dependency ของ Spring Boot
ARG DEPENDENCY=target/dependency

# คัดลอกไฟล์ที่จำเป็นไปยัง Container
COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

# คำสั่งที่ใช้รันแอป Spring Boot
ENTRYPOINT ["java", "-Dspring.profiles.active=${JAVA_PROFILE}", \
  "-cp", "app:app/lib/*", "camt.se234.lab10.Lab10Application"]
