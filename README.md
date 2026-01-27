# Beets - Docker

Custom [beets.io](https://beets.readthedocs.io/en/stable/index.html) docker image.

> [!IMPORTANT]
> Previous to `c09c487` commit, this image was `lscr.io/linuxserver/beets` + some plugins.

Each image is tagged with the hash of the latest build commit, for example: `ghcr.io/dpi0/beets-docker:01e8aee`

## Usage

```bash
docker compose run --rm beets import /hdd/Downloads/Music/Soulseek/Albums/Handsomeboy\ Technique\ -\ Adelie\ Land\ \[2005\]\ \[CD\ 320\]
```

You can use this sample `compose.yaml` for reference

<details> <summary><strong>compose.yaml</strong></summary>

```yaml
services:
  beets:
    image: ghcr.io/dpi0/beets-docker:latest
    container_name: beets
    volumes:
      - /data/beets/config:/data/config
      - /data/beets/db:/data/db
      - /data/beets/logs:/data/logs
      - /data/config/beets-config.yaml:/data/config/config.yaml
      - /hdd/Downloads/Music:/hdd/Downloads/Music
      - /hdd/Library/Music:/hdd/Library/Music
    user: "1000:1000"
    deploy:
      resources:
        limits:
          memory: 1G
          cpus: 1.0
    environment:
      PUID: $PUID
      PGID: $PGID
      TZ: $TZ
      BEETSDIR: /data/config
```

</details>

With this sample `beets-config.yaml`

<details> <summary><strong>beets-config.yaml</strong></summary>

```yaml
directory: /hdd/Library/Music
library: /data/db/musiclibrary.blb
art_filename: cover
original_date: yes
per_disc_numbering: yes
replace:
  '[\\/]': _
  '^\.': _
  '[\x00-\x1f]': _
  '[<>:"\?\*\|]': _
  '\.$': _
  '\s+$': ''
  '^\s+': ''
  '^-': _
import:
  copy: yes
  move: no
  resume: ask
  incremental: yes
  quiet: no
paths:
  singleton: Singles/$artist/$title
  default: Albums/$albumartist/[$year] $album%aunique{} [$format]/$track $title
  comp: Compilations/$album%aunique{} [$year] [$format]/$track $artist - $title
  albumtype_soundtrack: Soundtrack/$albumartist/[$year] $album%aunique{} [$format]/$track $title
match:
  strong_rec_thresh: 0.30
  medium_rec_thresh: 0.45
  rec_gap_thresh: 0.35
plugins:
  - embedart
  - fetchart
  - fromfilename
  - lastgenre
  - musicbrainz
  - scrub
  - zero
embedart:
  auto: yes
  ifempty: yes
fetchart:
  auto: yes
  minwidth: 800
  maxwidth: 0
  high_resolution: yes
  cover_format: jpg
  sources:
    - coverart
    - itunes
    - amazon
    - filesystem
lastgenre:
  auto: yes
  count: 3
  separator: '; '
  force: yes
  keep_existing: no
musicbrainz:
  search_limit: 10
  extra_tags: [catalognum, country, label, media, year]
  genres: yes
  external_ids:
    discogs: yes
scrub:
  auto: yes
zero:
  auto: yes
  fields: comments encoder albumdisambig
  omit_single_disc: yes
  update_database: true
```

</details>
