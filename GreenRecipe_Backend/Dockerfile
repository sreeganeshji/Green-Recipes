#base image for building the go project
FROM golang:1.14-alpine AS build

#update the repository and install git
RUN apk update && apk upgrade && \
apk add --no-cache git


RUN go get -u github.com/gorilla/mux
RUN go get github.com/lib/pq

#switches to directory like cd
WORKDIR /tmp/app

COPY . .

#builds the current project to a binary file called api in location /tmp/app/out/api

RUN GOOS=linux go build -o ./out/api .


FROM alpine:latest

RUN apk add ca-certificates

COPY --from=build /tmp/app/out/api /app/api

WORKDIR "/app"

EXPOSE 5000

CMD ["./api"]
