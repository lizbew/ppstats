local cjson = require('cjson')

local IndexController = {}

function IndexController:index()
    local view = self:getView()
    local p = {}
    p['vanilla'] = 'Welcome To Vanilla...'
    p['zhoujing'] = 'Power by Openresty'
    view:assign(p)
    return view:display()
end

function IndexController:test()
    local t = {aa = 'aa', bb = 'bb'}
    return cjson.encode(tt)
end

return IndexController
