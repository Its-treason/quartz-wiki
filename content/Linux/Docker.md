## Multi-arch Build

### Builder Setup

Install QEMOU to allow emulation of different arches. Using emulation is not the most efficient way to build an image. See [Docker docs](https://docs.docker.com/build/building/multi-platform/#qemu) for more other ways.

```shell
docker run --privileged --rm tonistiigi/binfmt --install all
```

Creating the new builder:

```shell
docker buildx create --name <Name> --bootstrap --use
```

Replace `<Name>` with a different name. The Flag `--use` will automaticity select the builder as default. Running `docker buildx ls` should show your new builder, with available platforms.

### Building an Image

Edit your Dockerfile to select the arch depending on the build argument.

```diff
- FROM alpine:latest
+ ARG ARCH=
+ FROM ${ARCH}alpine:latest
```

Now you can build your image using

docker buildx build --push --platform linux/arm64/v8,linux/amd64/v3 --tag OWNER/IMAGE:VERSION .

This will build the image in the current directory for arm64 & amd64 and push it into the registry to `OWNER/IMAGE:VERSION`.