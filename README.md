Neovim prebuilt dependencies
============================

This is a *write-only* repo of third-party dependencies for use by the Neovim
CI build.

- `src/`
    - cache of dependency sources
    - auto-updated by [GitHub actions](https://github.com/neovim/deps/blob/master/.github/workflows/nightly.yaml) whenever a dependency is added or bumped in [CMakeLists.txt](https://github.com/neovim/neovim/blob/master/cmake.deps/CMakeLists.txt).
    - Used by the [unstable PPA](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable). PPA builds aren't allowed network access, so a pre-build step fetches this repo to use as input to the build to ensure we have the latest dependencies.
- `opt/`
    - cache for manually-managed dependencies (not auto-updated because the origin is unreliable)
