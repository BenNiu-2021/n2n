FROM debian:stretch AS builder

ARG DEBIAN_FRONTEND=noninteractive

COPY . /n2n/

WORKDIR /n2n/

RUN ./autogen.sh && ./configure && make && make install



FROM debian:stretch
COPY --from=builder /n2n/supernode /n2n/

EXPOSE 7777 7777/udp

ENTRYPOINT ["/n2n/supernode", "-l" ,"7777"]