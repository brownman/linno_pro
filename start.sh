#!/usr/bin/env bash

git clone git@gitlab.linnovate.net:brownman/dockerizing_projects.git /tmp/my_project
cd /tmp/my_project
chmod +x .ci.sh
./.ci.sh user college
