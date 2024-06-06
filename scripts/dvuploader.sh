#!/bin/sh -e
exec docker run \
     --init \
     --rm  \
     --volume /srv/da:/srv/da:ro \
     --volume /srv/dataverse-prod/dvsantee/etl/processing:/srv/dataverse:ro \
     ghcr.io/berkeleylibrary/dvuploader:latest "$@"
