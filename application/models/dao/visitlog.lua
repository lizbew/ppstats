local _M = {}

local quote_sql_str = ndk.set_var.set_quote_pgsql_str

local dbquery = require('application.library.dbquery')


function _M.insert(record)
    local query = 'insert into visit_log(app_id, req_host, req_path, remote_ip, status, req_url, user_agent) '
        .. 'values ('
        .. quote_sql_str(record['app_id']) .. ', '
        .. quote_sql_str(record['req_host']) .. ', '
        .. quote_sql_str(record['req_path']) .. ', '
        .. quote_sql_str(record['remote_ip']) .. ', '
        .. quote_sql_str(record['status']) .. ', '
        .. quote_sql_str(record['req_url']) .. ', '
        .. quote_sql_str(record['user_agent']) 
        .. ')'

    local res = dbquery.query_db(query)
    return res.affected_rows
end

function _M.load_count()
    local query = [[select req_host || req_path as count_key, count(*) as visit_count
         from visit_log group by req_host, req_path]]
    
    local res = dbquery.query_db(query)
    return res
end

return _M
