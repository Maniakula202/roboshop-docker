FROM maven:3.5.4
WORKDIR /opt/server
COPY src/ .
COPY pom.xml .
RUN mvn clean package 
RUN mv target/shipping-1.0.jar shipping.jar
ENV CART_ENDPOINT="cart:8080" \
    DB_HOST="mysql"
CMD ["java", "-jar", "shipping.jar"]