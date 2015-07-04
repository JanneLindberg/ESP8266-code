--
--
--

json = require "cjson"

dofile("config.lua")
dofile("post_message.lua")
dofile("send_dht.lua")

tmr.stop(1)
tmr.alarm(1,30000,1,send_dht)
