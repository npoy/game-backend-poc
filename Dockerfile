# #TODO: Use specific version
# FROM golang:alpine as build

# # Set necessary environment variables needed for our image
# ENV GO111MODULE=on \
#     CGO_ENABLED=0 \
#     GOOS=linux \
#     GOARCH=amd64

# # Move to working directory /build
# WORKDIR /build

# # Copy and download dependency using go mod
# COPY go.mod .
# COPY go.sum .
# RUN go mod download

# # Copy the code into the container
# COPY . .

# # Build the application
# RUN go build -o main .

# #TODO: Test with another image (alpine)
# FROM golang:alpine as running-container

# # Move to /dist directory as the place for resulting binary folder
# WORKDIR /dist

# # Copy binary from build to main folder
# COPY --from=build /build/main .

# # Export necessary port
# EXPOSE 3000

# # Command to run when starting the container
# CMD ["/dist/main"]

FROM golang:alpine

# Set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
WORKDIR /dist

# Copy binary from build to main folder
RUN cp /build/main .

# Export necessary port
EXPOSE 3000

# Command to run when starting the container
CMD ["/dist/main"]