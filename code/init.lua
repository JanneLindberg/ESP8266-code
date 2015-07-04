--
--
--

dofile("config.lua")
dofile("post_message.lua")
dofile("send_dht.lua")

-- 
tmr.alarm(1,30000,1,send_dht)

-- tmr.alarm(1,15000,1,send_dht)
-- tmr.stop(1)
