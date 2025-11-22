Neovim prebuilt dependencies
============================

This is a *write-only* repo of third-party dependencies for use by the Neovim
CI build.

- `src/`
    - Cache of dependency sources.
    - https://github.com/neovim/deps/tree/master/src is an auto-updated snapshot
      of the `.deps/build/src/` produced by the Neovim `make deps` build task.
      - Hint: Use this with `USE_EXISTING_SRC_DIR=ON` to perform an ["offline" build](https://github.com/neovim/neovim/blob/master/BUILD.md#build-offline).
    - Auto-updated by [GitHub actions](https://github.com/neovim/deps/blob/master/.github/workflows/nightly.yaml) whenever a dependency is added or bumped in [CMakeLists.txt](https://github.com/neovim/neovim/blob/master/cmake.deps/deps.txt).
    - Used by the [unstable PPA](https://launchpad.net/~neovim-ppa/+archive/ubuntu/unstable). PPA builds aren't allowed network access, so a pre-build step fetches this repo to use as input to the build to ensure we have the latest dependencies.
- `opt/`
    - Manually-managed dependencies (not auto-updated because the origin is unreliable).
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
