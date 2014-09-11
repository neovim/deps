local site_config = {}
site_config.LUAROCKS_PREFIX=[[/opt/neovim-deps]]
site_config.LUA_INCDIR=[[/opt/neovim-deps/include/luajit-2.0]]
site_config.LUA_LIBDIR=[[/opt/neovim-deps/lib]]
site_config.LUA_BINDIR=[[/opt/neovim-deps/bin]]
site_config.LUA_INTERPRETER=[[luajit]]
site_config.LUAROCKS_SYSCONFDIR=[[/opt/neovim-deps/etc/luarocks]]
site_config.LUAROCKS_ROCKS_TREE=[[/opt/neovim-deps]]
site_config.LUAROCKS_FORCE_CONFIG=true
site_config.LUAROCKS_ROCKS_SUBDIR=[[/lib/luarocks/rocks]]
site_config.LUA_DIR_SET=true
site_config.LUAROCKS_UNAME_S=[[Linux]]
site_config.LUAROCKS_UNAME_M=[[x86_64]]
site_config.LUAROCKS_DOWNLOADER=[[curl]]
site_config.LUAROCKS_MD5CHECKER=[[md5sum]]
site_config.LUAROCKS_EXTERNAL_DEPS_SUBDIRS={ bin="bin", lib={ "lib", [[lib/x86_64-linux-gnu]] }, include="include" }
site_config.LUAROCKS_RUNTIME_EXTERNAL_DEPS_SUBDIRS={ bin="bin", lib={ "lib", [[lib/x86_64-linux-gnu]] }, include="include" }
return site_config
