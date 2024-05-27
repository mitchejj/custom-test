default:
  just base
  just build

fix_readme:
  deno fmt README.md

base version='40':
  buildah bud --format oci --build-arg FEDORA_MAJOR_VERSION={{version}} -t common-quark:{{version}} Containerfile 

build type='hypr' version='40':
  buildah bud --build-arg FEDORA_MAJOR_VERSION={{version}} --build-arg BASE_IMAGE_URL=localhost/common-quark -t {{type}}:{{version}} Containerfile.{{type}}
