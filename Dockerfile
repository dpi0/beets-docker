FROM python:3.12-alpine

RUN addgroup -g 1000 beetsgroup \
    && adduser -D -u 1000 -G beetsgroup beetsuser

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir --requirement /tmp/requirements.txt \
    && rm /tmp/requirements.txt

WORKDIR /home/beetsuser

USER 1000:1000

ENTRYPOINT ["beet"]
