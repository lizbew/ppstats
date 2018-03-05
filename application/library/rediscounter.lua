local _M = {}

local redis = require "resty.redis"

local counter_key = 'ppstats:pageview'

function _M.increment(key)
    local red = redis:new()
    
    red:set_timeout(1000) -- 1 sec
    
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        ngx.log(ngx.ERR, "failed to connect: ", err)
        return
    end
    

    local res, err = red:hincrby(counter_key, key, 1)
    if not res then
        ngx.log(ngx.ERR, "failed to set dog: ", err)
        return
    end

    ok, err = red:set_keepalive(10000, 100)
    if not ok then
        ngx.log(ngx.ERR, "failed to set keepalive: ", err)
        return
    end

    return res

end


return _M
