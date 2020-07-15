#!/bin/sh

CONF=/conf
CONF_SRC=/usr/src/app/conf

# if configuration file doesn't exist, copy the default
if [ ! -f $CONF/appdaemon.yaml ]; then
  cp $CONF_SRC/appdaemon.yaml.example $CONF/appdaemon.yaml
fi

# if apps folder doesn't exist, copy the default
if [ ! -d $CONF/apps ]; then
  cp -r $CONF_SRC/apps $CONF/apps
fi

# if apps file doesn't exist, copy the default
if [ ! -f $CONF/apps/apps.yaml ]; then
  cp $CONF_SRC/apps/apps.yaml.example $CONF/apps/apps.yaml
fi

# if dashboards folder doesn't exist, copy the default
if [ ! -d $CONF/dashboards ]; then
  cp -r $CONF_SRC/dashboards $CONF/dashboards
fi

#check recursively under CONF for additional python dependencies defined in requirements.txt
find $CONF -name requirements.txt -exec pip3 install --upgrade -r {} \;

# Lets run it!
exec appdaemon -c $CONF "$@"
