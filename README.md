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
    - `lua-dev-deps` is a combination of *only* the share files of `busted` and
      `luacheck`. The used versions are specified in the Makefile.

## Bumping dependency versions
The Makefile automatically performs the necessary steps to download and package
dependencies as needed. Run `make <dependency>` to package a single dependency
and just `make` to package all of them.

## Dependency-specific information
### Lpeg
We've vendored
[re.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/re.lua).
Remember to update it in the neovim repository when bumping the lpeg version.
