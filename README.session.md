# Sharp-libvips in Session

This is our own fork of `sharp-libvips`, with some changes to make it work with our specific needs.
Here are some details of how sharp and `sharp-libvips` are architected, so if someone has to come back to this project in 2 years, they can understand what's going on.

## High level overview

`sharp-libvips` is a project to clone and build all of the libvips dependencies.
Then sharp will use the prebuilt binaries to build a sharp.node module.

It generates through the CI a libvips for each supported platform and architecture. This step is very slow especially on darwin builds and takes +35minutes on the github runners.

## Differences with official sharp-libvips

### Supported platforms

We have removed some of the supported platforms and architectures from the official `sharp-libvips`, as Session is not planning to support them. Some of those remove are:

- linux-musl (glibc alternative)
- linux-armv6
- linux-ppc64le
- linux-riscv64
- linux-s390x
- win32 that are not for x64 or arm64

What we do support is:

- darwin-x64
- darwin-arm64
- linux-x64
- linux-arm64v8
- win32-x64
- win32-arm64

**Note:**

- **linux-sse2-x64** is not supported/tested yet, but we have added it to our fork.
- **linux-x64**, we have added a way to build `libvips` statically (i.e. `.a`) and kept the `.so` files. The `sharp.node` build is then allowed to pick one of the two depending on the platform when it gets built.

## Publishing

Our custom build is not publishing to npm, but only to [github releases](https://github.com/session-foundation/sharp-libvips/releases/).

Each build on each platform is uploaded separately and includes the files needed to build the `sharp.node` module for that specific platform.
There is no top level `sharp-libvips` package like we have of `sharp`.
So after a build through the CI, a new release is created on github, and that release contains a bunch .tar.gz that the prebuilt binaries.
So the release is not a npm package, but a set of `npm pack` .tar.gz files, uploaded to github as a release.

## Build a new release of sharp-libvips

If you do make changes to `sharp-libvips`, you'll need to build a new release.
The version doesn't have to match the official `sharp-libvips` version, but it should be a new version.

To build a new release through the CI, all you need to do is to

- remove the existing release on github for that version (Note: make sure no official release of session is using it, otherwise create a new version)
- change the release to be built by searching and replacing the current version in this project. For instance, search and replace `1.2.4` with `1.2.5`.
- remove the tag locally and remotely, and force push the changes (including the new tag)
- `git tag -d v1.2.5; git tag v1.2.5 && git push foundation -f && git push foundation -f tags/v1.2.5`

Note: the build needs a tag to generate a release, hence why you should delete and force push the tag each time you are iterating.

## Integrate that change in a new release of sharp

Once you have a new release of `sharp-libvips`, you can integrate it in a new release of `sharp`.
To see the steps for this, check the `README.session.md` in our own `session-foundation/sharp` repository.
