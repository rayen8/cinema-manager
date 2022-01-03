# Cinema Manager

 This is a cinema manager app for demo purposes. It is composed of two spring boot applications and two frontend apps, a mobile one using Flutter and another using Angular.
 
 ## Technologies
For the backend:
- The `server` is a secure REST API using **Spring Boot 2** with JDK 11 & custom security rules.
- The `jwt-microservice` creates tokens which will be used to authenticate in the server.

For the frontend:
- The `web-app` is an **Angular 9** app consuming the API.
- The `mobile-app` is a **Flutter** app also consuming the same API.

## Usage

### Starting the backend:
1. Start a database.
2. Run the `back` folder as a spring workspace.
3. Edit the `application.properties` of both projects.
4. Run both microservices with java.

### Starting the frontend:
Start the mobile app
```BASH
cd front/mobile_app && flutter pub get && flutter run
```

Start the web app
```BASH
cd front/web_app && npm install && npm start
```