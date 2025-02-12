FROM golang:latest as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o main .

FROM alpine:3.12
# Add Maintainer Info
LABEL maintainer="Nofar Bluestein <nofarb@gmail.com>"
# Copy the Go binary into the image. The Go binary must be
# statically compiled with CGO disabled. Use the following
# build command:
#
#   CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo
#
#ADD go-sample-app /bin/
COPY --from=builder /app/main /bin/go-sample-app
# Command to run the executable
ENTRYPOINT ["/bin/go-sample-app"]
