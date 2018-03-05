# ppstats

简单的页面访问统计功能，基于openresty的web框架 vanilla开发。

## 关键文件列表

* application/controllers/jstats.lua
* application/models/service/pagestats.lua
* application/models/dao/regapplication.lua
* application/models/dao/visitlog.lua
* application/library/dbquery.lua
* application/library/rediscounter.lua


## 依赖的工程及库

* https://github.com/openresty
* https://github.com/idevz/vanilla
* https://github.com/leafo/pgmoon

