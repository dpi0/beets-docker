FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libchromaprint-tools \
    build-essential \
    python3-dev \
    pkg-config \
    libsndfile1-dev \
    libsamplerate0-dev \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 beetsgroup \
    && useradd -m -u 1000 -g beetsgroup beetsuser

RUN mkdir -p /home/beetsuser/svm_models \
    && wget --progress=dot:giga https://essentia.upf.edu/extractors/essentia-extractors-v2.1_beta2-linux-x86_64.tar.gz \
    && tar -xzf essentia-extractors-v2.1_beta2-linux-x86_64.tar.gz -C /usr/local/bin/ --strip-components=1 --wildcards '*/streaming_extractor_music' \
    && rm essentia-extractors-v2.1_beta2-linux-x86_64.tar.gz \
    && wget --progress=dot:giga https://essentia.upf.edu/svm_models/essentia-extractor-svm_models-v2.1_beta5.tar.gz \
    && tar -xzf essentia-extractor-svm_models-v2.1_beta5.tar.gz -C /home/beetsuser/svm_models --strip-components=1 --wildcards '*.history' \
    && rm essentia-extractor-svm_models-v2.1_beta5.tar.gz \
    && chown -R beetsuser:beetsgroup /home/beetsuser/svm_models

COPY requirements.txt /tmp/requirements.txt

ENV CFLAGS="-Wno-incompatible-pointer-types"

RUN pip install --no-cache-dir --requirement /tmp/requirements.txt \
    && rm /tmp/requirements.txt

RUN apt-get purge -y --auto-remove build-essential python3-dev pkg-config wget

WORKDIR /home/beetsuser

USER 1000:1000

ENTRYPOINT ["beet"]
