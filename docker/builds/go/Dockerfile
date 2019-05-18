# Compile stage
FROM golang:1.12.5-alpine3.9
ENV CGO_ENABLED 0

RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN go get github.com/derekparker/delve/cmd/dlv

RUN apk add --no-cache libc6-compat
RUN echo 'alias build="go build -gcflags \"all=-N -l\" -o /riptides-go github.com/skyerus/riptides-go"' >> ~/.bashrc
RUN echo 'alias delve="go/bin/dlv --listen=:40000 --headless=true --api-version=2 exec /riptides-go"' >> ~/.bashrc
WORKDIR /
