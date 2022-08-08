#!/bin/bash
chmod 755 config.sh
chmod 755 run.sh

./config.sh --url $URL --token $TOKEN --unattended
./run.sh
