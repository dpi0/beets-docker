FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libchromaprint-tools \
    build-essential \
    python3-dev \
    pkg-config \
    libsndfile1-dev \
    libsamplerate0-dev \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup -g 1000 beetsgroup \
    && adduser -D -u 1000 -G beetsgroup beetsuser

COPY requirements.txt /tmp/requirements.txt

ENV CFLAGS="-Wno-incompatible-pointer-types"

RUN pip install --no-cache-dir --requirement /tmp/requirements.txt \
    && rm /tmp/requirements.txt

RUN apt-get purge -y --auto-remove build-essential python3-dev pkg-config

WORKDIR /home/beetsuser

USER 1000:1000

ENTRYPOINT ["beet"]
