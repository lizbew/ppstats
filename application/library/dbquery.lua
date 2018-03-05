local _M = {}

local pgmoon = require("pgmoon")

local db_spec = {
    host = '127.0.0.1',
    port = '5432',
    database = 'ppstats',
    user = 'ppstats',
    password = '----',
}

function _M.query_db(query)
    local pg = pgmoon.new(db_spec)

    print("sql query: ", query)

    local ok, err

    for i = 1, 3 do
        ok, err = pg:connect()
        if not ok then
            ngx.log(ngx.ERR, "failed to connect to database: ", err)
            ngx.sleep(0.1)
        else
            break
        end
    end

    if not ok then
        ngx.log(ngx.ERR, "fatal response due to query failures")
        return ngx.exit(500)
    end

    -- the caller should ensure that the query has no side effects
    local res
    for i = 1, 2 do
        res, err = pg:query(query)
        if not res then
            ngx.log(ngx.ERR, "failed to send query: ", err)

            ngx.sleep(0.1)

            ok, err = pg:connect()
            if not ok then
                ngx.log(ngx.ERR, "failed to connect to database: ", err)
                break
            end
        else
            break
        end
    end

    if not res then
        ngx.log(ngx.ERR, "fatal response due to query failures")
        return ngx.exit(500)
    end

    local ok, err = pg:keepalive(0, 5)
    if not ok then
        ngx.log(ngx.ERR, "failed to keep alive: ", err)
    end

    return res
end



return _M
