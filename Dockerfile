FROM debian:stretch AS builder


RUN apt-get update && apt-get install -y build-essential autoconf automake libtool gcc libc6-dev libssl-dev ca-certificates make git \
    && git clone https://github.com/ntop/n2n.git -b dev \
    && cd n2n/ \
    && git reset --hard 92dfa67 \
    && ./autogen.sh \
    && ./configure \
    && make && make install


FROM debian:stretch
COPY --from=builder /n2n/supernode /n2n/

EXPOSE 7777 7777/udp

ENTRYPOINT ["/n2n/supernode", "-l" ,"7777"]