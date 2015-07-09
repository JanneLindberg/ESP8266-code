--
--
--

json = require("cjson")

config = require("config")
require("send_dht")

-- Set static ip
wifi.sta.setip({ip="192.168.0.62",netmask="255.255.255.0",gateway="192.168.0.1"})

tmr.stop(1)
tmr.alarm(1,30000,1,send_dht)
