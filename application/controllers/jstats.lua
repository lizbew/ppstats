local JstatsController = {}

-- steps: 1. insert records to db, 2. increment redis counter, 3. return count
local cjson = require('cjson')

local PagestatsService = require('application.models.service.pagestats')

function JstatsController:index()
    local headers = self:getRequest().headers
    local params = self:getRequest().params

    -- do return cjson.encode(self:getRequest()) end 

    local appId = params.appid
    local req_host = params.host
    local req_path = params.path
    local remote_addr = headers['x-real-ip'] or  ngx.var.remote_addr
    if appId == nil or req_host == nil  or req_path == nil then
        return '-1'
    end

    local res = PagestatsService.accessPageView(appId, req_host, req_path, remote_addr, headers)
    return tostring(res);
end


return JstatsController
