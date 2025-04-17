#!/bin/sh -e
exec docker run \
     -t \
     --init \
     --rm  \
     --volume /srv/da:/srv/da:ro \
     --volume /srv/dataverse-prod/dvsantee/etl/dvuploader-tmp:/tmp \
     --volume /srv/dataverse-prod/dvsantee/etl/processing:/srv/dataverse:ro \
     ghcr.io/berkeleylibrary/dvuploader:latest "$@"
