FROM bitwalker/alpine-elixir:1.15 as builder

ADD . /app

WORKDIR /app

ENV MIX_ENV=prod

RUN mix do deps.get, compile, release

FROM alpine:3.6

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories

RUN apk update && apk add --no-cache \
	 ca-certificates \
     openssl-dev \
     ncurses-libs \
     unixodbc-dev \
     zlib-dev \
	 gcompat \
	 libgcc \
	 libstdc++ \
	 libc6-compat

RUN ln -s /usr/lib/libncurses.so.5.9 /usr/lib/libtinfo.so.6

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/dotp /app
RUN echo "secret" > /app/releases/COOKIE

ENV PORT=8080 \
	SHELL=/bin/sh 

CMD ["/app/bin/dotp", "start"]
