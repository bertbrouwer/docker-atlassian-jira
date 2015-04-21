# Jira Docker image

This folder contains the Dockerfile and associated files for the
`tehranian/docker-atlassian-jira` docker image which aims to serve as an example
for integrating Docker & Delphix.

See: http://blog.delphix.com/neilbatlivala/2015/04/16/why-docker-is-not-enough/

## Database connection

The connection to the Delphix virtual database can be specified with an URL
of the format:
```
[database type]://[username]:[password]@[host]:[port]/[database name]
```
Where `database type` is either `mysql` or `postgresql` and the full URL might
look like this:

```
postgresql://jira:jellyfish@172.17.0.2:7654/jiradb
```

## Configuration

Configuration options are set by setting environment variables when running the
image. What follows it a table of the supported variables:

Variable     | Function
-------------|------------------------------
CONTEXT_PATH | Context path of the Jira webapp. You can set this to add a path prefix to the url used to access the webapp. i.e. setting this to ```jira``` will change the url to http://localhost:8080/jira/. The value ```ROOT``` is reserved to mean that you don't want a context path prefix. Defaults to ```ROOT```
DATABASE_URL | Connection URL specifying where and how to connect to a database dedicated to jira. This variable is optional and if specified will cause the Jira setup wizard to skip the database setup set.
