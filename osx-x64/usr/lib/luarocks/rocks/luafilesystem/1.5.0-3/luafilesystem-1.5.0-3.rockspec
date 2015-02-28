package = "LuaFileSystem"
version = "1.5.0-3"
source = {
   url = "http://cloud.github.com/downloads/keplerproject/luafilesystem/luafilesystem-1.5.0.tar.gz"
}
description = {
   detailed = [[
      LuaFileSystem is a Lua library developed to complement the set of
      functions related to file systems offered by the standard Lua
      distribution. LuaFileSystem offers a portable way to access the
      underlying directory structure and file attributes.
   ]],
   homepage = "http://www.keplerproject.org/luafilesystem/",
   license = "MIT",
   summary = "File System Library for the Lua Programming Language"
}
dependencies = {
   "lua >= 5.1, < 5.2"
}
build = {
   type = "module",
   modules = {
      lfs = "src/lfs.c"
   },
   copy_directories = {
      "doc", "tests"
   }
}
