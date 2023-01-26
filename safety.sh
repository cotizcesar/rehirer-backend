#!/usr/bin/env bash
poetry export --without-hashes -f requirements.txt | safety check --full-report --stdin -i 51668
