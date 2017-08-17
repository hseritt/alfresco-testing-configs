#!/usr/bin/env bash

for pid in $(ps -ef | grep tomcat | grep -v grep | awk '{print $2}'); do kill -9 $pid; done

