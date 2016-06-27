#!/bin/sh
set -ex

rm -rf app
flatpak-builder --ccache --require-changes --repo=repo --subject="Nightly build of Something For Reddit, `date`" app com.github.samdroid_apps.something_for_reddit.json

flatpak build-update-repo --prune --prune-depth=20 repo

# The following commands should be performed once
flatpak --user remote-add --no-gpg-verify nightly-sfr ./repo || true
flatpak --user -v install nightly-sfr com.github.samdroid_apps.something_for_reddit || true

flatpak update --user com.github.samdroid_apps.something_for_reddit
