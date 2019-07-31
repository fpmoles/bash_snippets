#!/usr/bin/env bash

uuid() {
   uuid=$(uuidgen)
   echo $uuid | tr '[:upper:]' '[:lower:]'
}

uuid
