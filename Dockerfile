FROM debian:stretch AS builder

COPY . /n2n/

WORKDIR /n2n/

RUN apt-get update && apt-get install -y gcc libc6-dev libssl-dev ca-certificates make git\
    && chmod +x ./autogen.sh && bash ./autogen.sh && ./configure && make && make install


FROM debian:stretch
COPY --from=builder /n2n/supernode /n2n/

EXPOSE 7777 7777/udp

ENTRYPOINT ["/n2n/supernode", "-l" ,"7777"]