# docker-bake.hcl
#
# This file defines build targets for all Docker images in this repository.
# Use `docker buildx bake` to build images locally or in CI.
#
# Usage:
#   docker buildx bake              # Build all images (defaults to local)
#   docker buildx bake infra        # Build only infra images
#   docker buildx bake builder      # Build a specific image
#   BUILD_ENV=prod docker buildx bake --push  # Build and push production images

# --- Variables ---

variable "REGISTRY" {
  default = "ghcr.io/mrs-electronics-inc/qt-docker"
}

# BUILD_ENV controls the image tags and attestations.
# - "local": Tags images with :local, no attestations (for local development)
# - "prod":  Tags images with :latest, includes provenance and SBOM attestations
variable "BUILD_ENV" {
  default = "local"

  validation {
    condition     = BUILD_ENV == "prod" || BUILD_ENV == "local"
    error_message = "BUILD_ENV must be 'prod' or 'local'."
  }
}

# --- Groups ---

# Default group builds all infra images
group "default" {
  targets = ["infra", "public"]
}

# Private infrastructure images used to build public images
group "infra" {
  targets = ["builder", "base"]
}

# --- Abstract targets ---

# Common configuration inherited by all image targets
target "_common" {
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64"]
  # Production builds include provenance and SBOM attestations for supply chain security
  attest = BUILD_ENV == "prod" ? ["type=provenance,mode=max", "type=sbom"] : []
}

# --- Public images ---

# This matrix target will build all of the public images at once.
target "public" {
  inherits = [ "_common" ]
  name = tgt
  matrix = {
    "tgt" = [ "full" ]
  }
  context = "public/${tgt}"
  tags = ["${REGISTRY}/${tgt}:${BUILD_ENV == "prod" ? "latest" : "local"}"]
}

# --- Infra images ---

# Builder image: Contains Qt SDK installations (Qt 5.15.0 and Qt 6.8.0)
# Used as a source for COPY --from in public images
target "builder" {
  inherits   = ["_common"]
  context    = "infra/builder"
  tags       = ["${REGISTRY}/builder:${BUILD_ENV == "prod" ? "latest" : "local"}"]
}

# Base image: Minimal Debian image with Qt runtime dependencies
# Used as the FROM base for all public images
target "base" {
  inherits   = ["_common"]
  context    = "infra/base"
  tags       = ["${REGISTRY}/base:${BUILD_ENV == "prod" ? "latest" : "local"}"]
}
