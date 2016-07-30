Neovim prebuilt dependencies
============================

This is a *write-only* repo of third-party dependencies for use by the Neovim
CI build.

- `src/`
    - cache of dependency sources
    - auto-updated by [bot-ci](https://github.com/neovim/bot-ci/blob/master/ci/common/deps-repo.sh) whenever a dependency is added or bumped in [CMakeLists.txt](https://github.com/neovim/neovim/blob/master/third-party/CMakeLists.txt).
- `opt/`
    - cache for manually-managed dependencies (not auto-updated because the origin is unreliable)

