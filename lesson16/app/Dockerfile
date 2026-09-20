FROM golang:1.22-alpine AS build

WORKDIR /app

COPY . .

RUN go build -o web-app .

FROM alpine:latest

WORKDIR /app

COPY --from=build /app/web-app .
COPY --from=build /app/static ./static

EXPOSE 8080

ENTRYPOINT ["./web-app"]
