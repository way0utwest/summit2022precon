## We will need to establish a baseline prior to connect
## Be sure flyway.conf is configured for the correct instance, login & password
flyway baseline

## Create first script, put in appropriate location per flyway.locations
flyway migrate