libvterm_url = https://launchpad.net/libvterm/trunk/v0.3/+download/libvterm-0.3.3.tar.gz
lpeg_url = https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.1.0.tar.gz
libtermkey_url = https://www.leonerd.org.uk/code/libtermkey/libtermkey-0.22.tar.gz

lua-dev:
	luarocks install --tree lua_modules busted 2.1.1
	luarocks install --tree lua_modules luacheck 1.1.0
	mv lua_modules/share/lua/* ./lua-dev-deps
	COPYFILE_DISABLE=1 tar czf lua-dev-deps.tar.gz lua-dev-deps
	rm -rf lua-dev-deps
	mv lua-dev-deps.tar.gz opt

libvterm libtermkey lpeg:
	wget --directory-prefix=opt $($@_url)
