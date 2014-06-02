package="sha2"
version="0.2.0-1"
source = {
	url = "http://sha2.googlecode.com/hg/sha2-0.2.0.zip",
}
description = {
	summary = "Lua binding for Aaron Gifford's SHA-2 implementation",
	detailed = [[
		Lua Binding for the SHA-2 (SHA-256/384/512) BSD-licensed C implementation by Aaron Gifford.
		Also contains a HMAC implementation in Lua.
	]],
	homepage = "http://code.google.com/p/sha2/",
	license = "MIT/X11",
	maintainer = "cosmin.apreutesei@gmail.com",
}
dependencies = {
	"lua >= 5.1"
}

build = {
	type = "builtin",
	modules = {
		sha2 = {
			sources = { "sha2.c", "sha2lib.c" },
			incdirs = { "." }, --I wish I wouldn't have to specify this
			defines = { "SHA2_USE_INTTYPES_H", "BYTE_ORDER", "LITTLE_ENDIAN" },
		},
		hmac = "hmac.lua",
		["hmac.sha2"] = "hmac/sha2.lua",
		["hmac.md5"] = "hmac/md5.lua",
	},
	copy_directories = { "tests" }
}

