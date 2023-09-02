FROM rust:1.72-bullseye as builder

RUN USER=root cargo new --bin osinfo

# Create a new directory for our application
WORKDIR /osinfo

# Copy the Cargo.toml and Cargo.lock files to the container
COPY Cargo.toml Cargo.lock ./

# Build the dependencies and cache them
RUN cargo build --release

# Remove the .rs files created by cargo
RUN rm src/*.rs

# Copy the source files to the container
ADD . ./

# Remove the dummy target directory created by cargo
RUN rm ./target/release/deps/osinfo*

# Build the application
RUN cargo build --release

# Create a new stage and copy the binary from the builder stage
FROM rust:1.72-slim-bullseye as runner
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /osinfo/target/release/osinfo /app

# Run the application
CMD ["./osinfo"]