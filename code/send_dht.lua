-- ****************************************************************************
-- ESP8266-01
--
--
-- Send DHT sensor data connected to GPIO2 (4)
--
-- dev-id: dev.<ID>.<TYPE> payload: {:value <VALUE>, :unit RH}
--
-- ****************************************************************************

json = require "cjson"

function send_dht()
   status,temp,rh,temp_decimial,humi_decimial = dht.read(4)

   local t = {}
   local payload={}
   
   payload["value"] = tostring(rh)
   payload["unit"] = "RH"
   t["dev-id"] = "dev."..node.chipid()..".rh"
   t["payload"] = payload

   local msg1 = json.encode(t)
--   print(msg1)

   payload={}
   payload["value"] = tostring(temp)
   payload["unit"] = "℃"
   t = {}
   t["dev-id"] = "dev."..node.chipid()..".temp"
   t["payload"] = payload
   
   local msg2 = json.encode(t)
--   print(msg2)

   local msg0="["..msg1..","..msg2.."]\r\n"
   print(msg0)

   post_message(serv_host,serv_port,msg0)
   
end
