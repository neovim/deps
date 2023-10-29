lpeg_url = https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.1.0.tar.gz

lua-dev:
	luarocks install --tree lua_modules busted 2.1.1
	luarocks install --tree lua_modules luacheck 1.1.0
	mv lua_modules/share/lua/* ./lua-dev-deps
	COPYFILE_DISABLE=1 tar czf lua-dev-deps.tar.gz lua-dev-deps
	rm -rf lua-dev-deps
	mv lua-dev-deps.tar.gz opt

lpeg:
	wget --directory-prefix=opt $($@_url)
