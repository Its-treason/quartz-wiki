## Multi-arch Build

### Builder Setup

Install QEMU to allow emulation of different arches. Using emulation is not the most efficient way to build an image. See the [Docker docs](https://docs.docker.com/build/building/multi-platform/#qemu) for other ways.

```shell
docker run --privileged --rm tonistiigi/binfmt --install all
```

`tonistiigi/binfmt` bundles static QEMU binaries and registers them with the kernel's `binfmt_misc`, so foreign-arch binaries (e.g. arm64 on an amd64 host) get transparently run through QEMU during the build. It's maintained by [Tõnis Tiigi](https://www.docker.com/contributors/tonis-tiigi/), who also maintains `docker/buildx` and BuildKit itself.

Creating the new builder:

```shell
docker buildx create --name <Name> --bootstrap --use
```

Replace `<Name>` with a different name. The flag `--use` will automatically select the builder as default. Running `docker buildx ls` should show your new builder, with available platforms.

### Building an Image

Edit your Dockerfile to select the arch depending on the build argument.

```diff
- FROM alpine:latest
+ ARG ARCH=
+ FROM ${ARCH}alpine:latest
```

Now you can build your image using

```shell
docker buildx build --push --platform linux/arm64/v8,linux/amd64/v3 --tag OWNER/IMAGE:VERSION .
```

This will build the image in the current directory for arm64 & amd64 and push it into the registry to `OWNER/IMAGE:VERSION`.