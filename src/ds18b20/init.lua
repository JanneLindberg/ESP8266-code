--
--
-- DS18B20's connected to GPIO0
--

t=require("ds18b20")
t.setup(3)

config = require("config")
require("send_temp")

-- Set static ip
wifi.sta.setip({ip="192.168.0.62",netmask="255.255.255.0",gateway="192.168.0.1"})

tmr.stop(1)
tmr.alarm(1,60000,1,send_temp_data)

