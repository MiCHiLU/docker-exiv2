FROM alpine:edge

RUN apk --no-cache --update add \
  expat \
  libgcc \
  libstdc++ \
  ;

ARG \
  exiv=0.25

RUN apk --no-cache --update add --virtual=build-deps \
  autoconf \
  bash \
  curl \
  expat-dev \
  g++ \
  make \
  zlib-dev \
  && mkdir src \
  && (cd src \
    && curl -sL https://github.com/Exiv2/exiv2/archive/${exiv}.tar.gz \
    | tar xzf - --strip-components 1 \
    && make config \
    && ./configure \
    && make \
    && make install \
  ) \
  && rm -rf src \
  && apk del build-deps

ENTRYPOINT ["exiv2"]

WORKDIR /root
