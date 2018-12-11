#!/usr/bin/env bash

_aggregate() {
  echo '' > slides.md
  [ -d img ] || mkdir img

  for scene in ./scene*; do
    cat "$scene/README.md" >> slides.md
    [ -d "$scene/img" ] && cp -r "$scene/img/"* ./img/
  done
}

_clean() {
  rm -rf ./slides.md ./img
}

_main() {
  _aggregate
  trap _clean SIGINT
  reveal-md ./slides.md --title "Docker & K8s 101" --theme league
}

_main
