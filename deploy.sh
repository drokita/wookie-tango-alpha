#!/bin/bash
APP=/Volumes/Macintosh\ HD/Users/drokita/Development/java/blog/target
WEBAPPS=/usr/local/Cellar/tomcat/8.0.32/libexec/webapps
PACKAGE=$1

cp "$APP"/$PACKAGE $WEBAPPS

catalina stop
catalina start