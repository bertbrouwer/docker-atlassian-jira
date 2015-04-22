#!/bin/bash
set -o errexit

. /usr/local/share/atlassian/common.bash

rm -fv /opt/atlassian-home/.jira-home.lock

if [ "$CONTEXT_PATH" == "ROOT" -o -z "$CONTEXT_PATH" ]; then
  CONTEXT_PATH=
else
  CONTEXT_PATH="/$CONTEXT_PATH"
fi

xmlstarlet ed -u '//Context/@path' -v "$CONTEXT_PATH" conf/server-backup.xml > conf/server.xml

if [ -n "$DATABASE_URL" ]; then
  extract_database_url "$DATABASE_URL" DB /opt/jira/lib
  DB_JDBC_URL="$(xmlstarlet esc "$DB_JDBC_URL")"

  sed \
    -i.bak \
    -e "s#<database-type>.*#<database-type>$DB_TYPE</database-type>#" \
    -e "s#<url>.*#<url>$DB_JDBC_URL</url>#" \
    -e "s#<driver-class>.*#<driver-class>$DB_JDBC_DRIVER</driver-class>#" \
    -e "s#<username>.*#<username>$DB_USER</username>#" \
    -e "s#<password>.*#<password>$DB_PASSWORD</password>#" \
    /opt/atlassian-home/dbconfig.xml
fi

/opt/jira/bin/start-jira.sh -fg
