FROM lscr.io/linuxserver/beets:2.5.1

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt
