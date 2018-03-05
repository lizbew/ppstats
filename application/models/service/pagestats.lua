local _M = {}



local appDao = require('application.models.dao.regapplication')
local visitlogDao = require('application.models.dao.visitlog')
local redisCounter = require('application.library.rediscounter')

function _M.accessPageView(appId, req_host, req_path, remote_addr, headers)
    local allow_hosts = appDao.check_appid_host(appId, req_host)

    if #allow_hosts == 0 then
        return 0
    end

    local record = {
        app_id = appId,
        req_host = req_host,
        req_path = req_path,
        remote_ip = remote_addr, 
        req_url = headers['referer'] or '', 
        user_agent = headers['user-agent'] or '',
        status = 'ok', 
    }

    local nums = visitlogDao.insert(record)
    local pageview = 0
    if nums > 0 then
        local page = req_host .. req_path
        local res = redisCounter.increment(page)
        if res then
            pageview = res
        end
    end 
    
    return pageview
end

return _M
