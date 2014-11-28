package = 'lua-MessagePack'
version = '0.3.1-1'
source = {
    url = 'http://sites.google.com/site/fperrad/lua-messagepack-0.3.1.tar.gz',
    md5 = '3b11cbd32c9dfe3bbc493eae33ab8cab',
    dir = 'lua-MessagePack-0.3.1',
}
description = {
    summary = "a pure Lua implementation of the MessagePack serialization format",
    detailed = [[
        MessagePack is an efficient binary serialization format.

        It lets you exchange data among multiple languages like JSON but it's faster and smaller.
    ]],
    homepage = 'http://fperrad.github.io/lua-MessagePack/',
    maintainer = 'Francois Perrad',
    license = 'MIT/X11'
}
dependencies = {
    'lua >= 5.1',
}
build = {
    type = 'builtin',
    modules = {
        ['MessagePack']     = 'src/MessagePack.lua',
    },
    copy_directories = { 'doc', 'test' },
}
