FROM alpine:3.14.0 AS builder

RUN apk add openssl-dev build-base make git cmake gcc libc-dev bsd-compat-headers linux-headers musl-dev bash bash-doc bash-completion autoconf automake \
    && git clone https://github.com/ntop/n2n.git -b dev \
    && cd n2n/ \
    && git reset --hard 92dfa67 \
    && ./autogen.sh \
    && ./configure \
    && make && make install


FROM alpine:3.14.0
COPY --from=builder /n2n/supernode /n2n/

EXPOSE 7777 7777/udp

ENTRYPOINT ["/n2n/supernode", "-l" ,"7777"]