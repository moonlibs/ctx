package = 'ctx'
version = 'scm-1'
source  = {
    url    = 'git://github.com/moonlibs/ctx.git',
    branch = 'master',
}
description = {
    summary  = "Package for context request and logs",
    homepage = 'https://github.com/moonlibs/ctx.git',
    license  = 'BSD',
}
dependencies = {
    'lua >= 5.1'
}
build = {
    type = 'builtin',
    modules = {
        ['ctx'] = 'ctx.lua',
        ['ctx.log'] = 'ctx/log.lua',
    }
}

-- vim: syntax=lua
