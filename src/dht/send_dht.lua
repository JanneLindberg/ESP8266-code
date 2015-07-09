-- ****************************************************************************
-- ESP8266-01
--
--
-- Send DHT sensor data connected to GPIO2 (4)
--
-- dev-id: dev.<ID>.<TYPE> payload: {:value <VALUE>, :unit RH}
--
-- ****************************************************************************

local gpio2=4

local function post_message(msg)
   local con=net.createConnection(net.TCP,0)
   con:on("receive", function(con, c) print(c) end)
   con:connect(config.port,config.host)
   con:send("POST "..config.endpoint.." HTTP/1.1\r\n")
   con:send("Content-Type: application/json\r\n")
   con:send("Accept: application/json\r\n")
   con:send("content-length:"..string.len(msg).."\r\n")
   con:send("\r\n")
   con:send(msg)
   con:send("\r\n")
   con:on("sent",function(conn)
             conn:close()
             collectgarbage()
   end
   )
end


function send_dht()
   status,temp,rh,temp_decimial,humi_decimial = dht.read(gpio2)

   local t = {}
   local payload={}
   
   payload["value"] = tostring(rh)
   payload["unit"] = "RH"
   t["dev-id"] = "dev."..node.chipid()..".rh"
   t["payload"] = payload

   local rh_msg = json.encode(t)

   payload={}
   payload["value"] = tostring(temp)
   payload["unit"] = "temp"
   t = {}
   t["dev-id"] = "dev."..node.chipid()..".temp"
   t["payload"] = payload
   
   local temp_msg = json.encode(t)
   
   local msg0="["..rh_msg..","..temp_msg.."]\r\n"

   post_message(msg0)

end
