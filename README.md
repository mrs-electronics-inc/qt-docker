# qt-docker

Custom Docker images with Qt installations for use in CI/CD pipelines.

> [!WARNING]
> ⚠️⚠️⚠️
>
> This project is a work-in-progress. Many of the features listed below are in the planning stages, and have not been implemented yet.
> Check back regularly for updates!

## Image Details

This project exports various Docker images that can be used for compiling Qt/C++ projects for MRS products. There are a few different images that target specific products, along with an image that contains toolchains for all products.

This table summarizes what each public image includes:

| Image | Yocto Qt6 | Yocto Qt5 | Buildroot Qt5 | Desktop Qt6 | Desktop Qt5 |
| --- | --- | --- | --- | --- | --- |
| `mrs-electronics-inc/qt-docker/neuralplex` | ✅ | X | X | ✅ | X |
| `mrs-electronics-inc/qt-docker/mconn` | X | ✅ | ✅ | X | ✅ |
| `mrs-electronics-inc/qt-docker/fusion` | X | X | ✅ | X | ✅ |
| `mrs-electronics-inc/qt-docker/all` | ✅ | ✅ | ✅ | ✅ | ✅ |

> [!NOTE]
>
> The `mrs-electronics/qt-docker/builder` and `mrs-electronics/qt-docker/builder` images are private and are only meant to be used during creation of the user-facing images.
