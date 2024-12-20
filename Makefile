lpeg_url = https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.1.0.tar.gz
gettext_url = https://ftp.gnu.org/pub/gnu/gettext/gettext-0.20.1.tar.gz
libiconv_url = https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.17.tar.gz

busted_version = 2.2.0
luacheck_version = 1.2.0

all: lua-dev lpeg gettext libiconv

lua-dev:
	luarocks install --tree lua_modules busted $(busted_version)
	luarocks install --tree lua_modules luacheck $(luacheck_version)
	mv lua_modules/share/lua/* ./lua-dev-deps

	# Mac tar converts extended attributes (such as `com.apple.quarantine`
	# for files downloaded with Safari) to hidden files, which will break
	# the installation step on Windows and Linux. `COPYFILE_DISABLE=1` is
	# needed to create cross-platform archives
	COPYFILE_DISABLE=1 tar czf lua-dev-deps.tar.gz lua-dev-deps
	rm -rf lua-dev-deps lua_modules
	mv lua-dev-deps.tar.gz opt

lpeg gettext libiconv:
	wget --directory-prefix=opt $($@_url)
