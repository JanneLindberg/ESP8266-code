-- ****************************************************************************
-- ESP8266-01
--
-- Send DS18B20 sensor data connected to GPIO0 (3)
--
-- dev-id: dev.<ID>.<TYPE> payload: {:value <VALUE>, :unit RH}
--
-- ****************************************************************************

function post(msg)
   local con=net.createConnection(net.TCP,0)
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


function send_data(t, addr)
   local json = require("cjson")
   local devid = string.format("%02X-%02X%02X%02X%02X%02X%02X",
                               addr:byte(1),addr:byte(7),addr:byte(6),addr:byte(5),
                               addr:byte(4),addr:byte(3),addr:byte(2))
   
   local msg = {}
   local payload = {}

   payload["value"] = tostring(t.read(addr,t.C))
   msg["dev-id"] = "dev."..devid..".temp"
   msg["payload"] = payload
   local msg1 = json.encode(msg)

   msg=nil
   payload=nil
   devid=nil

   print("["..msg1.."]")
   post("["..msg1.."]")

   msg1=nil
   json=nil
end


function send_temp_data()
   local addrs=t.addrs()

   for i=1,#addrs do
      send_data(t, addrs[i])
   end

   addrs = nil   
end
