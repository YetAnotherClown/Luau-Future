#!/bin/sh

set -e

wally install \
    && wally-package-types --sourcemap sourcemap.json DevPackages/