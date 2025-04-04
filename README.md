# DVUploader Docker Wrapper

This wraps the Python [dvuploader](https://github.com/gdcc/python-dvuploader/) package that provides parallel direct upload to Dataverse. There's also a `java` branch to track the [Java dvuploader](https://github.com/GlobalDataverseCommunityConsortium/dataverse-uploader) which we have used in the past.

## Volumes

The wrapper needs both Digital Assets and the Dataverse Prod volumes mounted at the following locations:

```
Digital Assets  -> /srv/da
Dataverse       -> /srv/dataverse-prod
```

## Permissions

You don't necessarily want to give docker rights to users of this script, since docker implies root permissions. You can extend a limited ability to run the script with the following workaround (see [`scripts`](scripts)):

```sh
# In system-wide profile
alias dvuploader="sudo /usr/local/sbin/dvuploader.sh"

# In /usr/local/sbin/dvuploader.sh
#!/bin/sh -e
exec docker run \
     -t \
     --init \
     --rm  \
     --volume /srv/da:/srv/da:ro \
     --volume /srv/dataverse-prod/dvsantee/etl/dvuploader-tmp:/tmp \
     --volume /srv/dataverse-prod/dvsantee/etl/processing:/srv/dataverse:ro \
     ghcr.io/berkeleylibrary/dvuploader:latest "$@"

# In /etc/sudoers.d/dvuploader
# MUST USE visudo to ensure the syntax is correct and avoid breaking sudo.
Defaults!/usr/local/sbin/dvuploader.sh env_keep += "HOME"
Defaults!/usr/local/sbin/dvuploader.sh !always_set_home
%dpgdil ALL=(root) NOPASSWD: /usr/local/sbin/dvuploader.sh

# Then members of dpgdil can run your script like so
dvuploader da/path/to/some/filepaths --api-token $key --dataverse-url $server 
dvuploader /srv/dataverse/XXXXX --api-token xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx --dataverse-url https://datasets.lib.berkeley.edu --pid doi:10.60503/D3/XXXXX --recurse 

# Note that the local directory /srv/dataverse-prod/dvsantee/etl/processing/ is mapped to /srv/dataverse when you run the dvuploader script
```
