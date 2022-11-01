FROM rust:1.64.0

COPY . /app
WORKDIR /app

RUN cargo build --release
RUN cp ./target/release/texture-replacer-api .
RUN rm -r ./target
EXPOSE 8000

CMD ["./texture-replacer-api"]