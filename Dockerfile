FROM linuxserver/beets:2.5.1

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir --no-deps -r /tmp/requirements.txt \
    && pip install --no-cache-dir --no-deps librosa==0.10.2.post1
