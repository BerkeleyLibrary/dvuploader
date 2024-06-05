# DVUploader Docker Wrapper

## Volumes

The wrapper needs both Digital Assets and the Dataverse Prod volumes mounted at the following locations:

```
Digital Assets  -> /srv/da
Dataverse       -> /srv/dataverse-prod
```

## Permissions

You don't necessarily want to give docker rights to users of this script, since docker implies root permissions. You can extend a limited ability to run the script with the following workaround:

```sh
# In system-wide profile
alias dvuploader="sudo /usr/local/sbin/dvuploader.sh"

# In /usr/local/sbin/dvuploader.sh
#!/bin/sh -e
exec docker run \
  --init \
  --quiet \
  --rm \
  --volume /srv/da:/opt/app/da:ro \
  --volume /srv/dataverse-prod/dvsantee/etl/processing:/opt/app/dataverse:ro \
  ghcr.io/berkeleylibrary/dvuploader:latest "$@"

# In /etc/sudoers.d/dvuploader
# MUST USE visudo to ensure the syntax is correct and avoid breaking sudo.
Defaults!/usr/local/sbin/dvuploader.sh env_keep += "HOME"
Defaults!/usr/local/sbin/dvuploader.sh !always_set_home
%dpgdil ALL=(root) NOPASSWD: /usr/local/sbin/dvuploader.sh

# Then members of dpgdil can run your script like so
dvuploader -key=$key -server=$server da/path/to/some/datadir
```
