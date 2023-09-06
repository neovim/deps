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
    - `lua-dev-deps` is a combination of *only* the share files of `busted`
      v2.1.1 and `luacheck` v1.1.0.

## For Mac users

Mac tar converts extended attributes (such as `com.apple.quarantine` for files
downloaded with Safari) to hidden files, which will break the installation step
on Windows and Linux. Prepend tar with `COPYFILE_DISABLE=1` to create
cross-platform archives:

```
COPYFILE_DISABLE=1 tar czf busted-2.1.1.tar.gz busted-2.1.1
```

## Dependency-specific information
### Lpeg
We've vendored
[re.lua](https://github.com/neovim/neovim/blob/master/runtime/lua/vim/re.lua).
Remember to update it in the neovim repository when bumping the lpeg version.
