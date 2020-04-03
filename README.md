# ruby-ci-docker-image

## Building
```
# To build the ruby docker image
$ make image
```

Use the `VERSION` environment variable to build a specific tag
```
$ VERSION=2.7.1 make image
```

All builds will tag the version as well as `latest`.

## Pushing Image
To push the image to docker hub:
```
# To push the latest versions
$ make docker/push/latest

# To push the tagged versions
$ make docker/push/version

# To push both
$ make docker/push
```
