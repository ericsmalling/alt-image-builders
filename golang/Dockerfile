FROM golang AS build
WORKDIR /go/src
COPY . .
RUN GOOS=linux go build -ldflags "-linkmode external -extldflags -static" -a hello.go

FROM gcr.io/distroless/static:nonroot
USER nonroot:nonroot
COPY --from=build /go/src/hello .
EXPOSE 8080
CMD ["./hello"]
