local _M = {}

local quote_sql_str = ndk.set_var.set_quote_pgsql_str

local dbquery = require('application.library.dbquery')


function _M.check_appid_host(appid, host)
    local query = "select h.app_id, h.host from reg_application a, allow_hosts h where a.app_id = h.app_id and  a.app_id = "
    .. quote_sql_str(appid) .." and h.host = ".. quote_sql_str(host) .." and a.status = 'ok' and h.status = 'ok'"

    local res = dbquery.query_db(query)
    return res
end

return _M
