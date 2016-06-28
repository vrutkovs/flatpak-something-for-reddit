#!/bin/sh
set -ex

rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Something For Reddit, `date`" app today.sam.reddit_is_gtk.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-sfr ./repo || true
flatpak --user install nightly-sfr today.sam.reddit_is_gtk || true

flatpak update --user today.sam.reddit_is_gtk
