--
--
-- DS18B20's connected to GPIO0
--

t=require("ds18b20")
t.setup(3)

require("config")
require("post")
require("send_temp")


tmr.stop(1)
tmr.alarm(1,60000,1,send_temp_data)

