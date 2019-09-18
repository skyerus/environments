# Compile stage
FROM golang:1.12.5-alpine3.9
ENV CGO_ENABLED 0

RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN go get github.com/derekparker/delve/cmd/dlv

RUN apk add --no-cache libc6-compat
RUN echo 'alias build="go build -gcflags \"all=-N -l\" -o /itunes-to-spotify github.com/skyerus/itunes-to-spotify"' >> ~/.bashrc
WORKDIR /
