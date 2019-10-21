package = "cone"
version = "scm-1"
source = {
   url = "https://github.com/bartfeenstra/cone.git"
}
description = {
   homepage = "https://github.com/bartfeenstra/cone",
   license = "MIT"
}
dependencies = {}
build = {
   type = "builtin",
   modules = {
      cone = "cone.lua",
      cone_spec = "cone_spec.lua"
   }
}
