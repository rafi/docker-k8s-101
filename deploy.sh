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
  rm -rf ./slides.md ./img ./_static
}

_build() {
  reveal-md ./slides.md --title "Docker & K8s 101" --theme league --static
}

_deploy() {
  rsync -az --delete _static/* bob:/srv/http/rafi.io/slides/docker-k8s-101/
}

_main() {
  _aggregate
  _build
  _deploy
  _clean
  open "http://rafi.io/slides/docker-k8s-101"
}

_main
