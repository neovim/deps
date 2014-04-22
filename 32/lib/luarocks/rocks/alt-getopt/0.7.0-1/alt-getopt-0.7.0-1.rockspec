package = "alt-getopt"
version = "0.7.0-1"
source = {
   url = "http://luaforge.net/frs/download.php/4260/lua-alt-getopt-0.7.0.tar.gz"
}
description = {
   summary = "Process application arguments the same way as getopt_long",
   detailed = [[
       alt-getopt is a module for Lua programming language for processing
       application's arguments the same way BSD/GNU getopt_long(3) functions do.
       The main goal is compatibility with SUS "Utility Syntax Guidelines"
       guidelines 3-13.
   ]],
   homepage = "http://luaforge.net/projects/alt-getopt/", 
   license = "MIT/X11" 
}
dependencies = {
   "lua >= 5.1"
}

build = {
   type = "builtin",
   modules = {
      ["alt_getopt"] = "alt_getopt.lua"
   }
}


