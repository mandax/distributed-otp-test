FROM elixir:1.14-otp-25-alpine as builder

WORKDIR /app

COPY mix.exs mix.lock ./
COPY config/config.exs config/
COPY lib lib
COPY rel rel

ENV MIX_ENV=prod

RUN mix do deps.get, compile
RUN mix release driver

FROM elixir:1.14-otp-25-alpine

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/driver /app

# Default port from erlang port mapping daemon (epmd)
EXPOSE 4369 

CMD ["/app/bin/driver", "start"]
