FROM lscr.io/linuxserver/beets:2021.12.16

COPY requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt
