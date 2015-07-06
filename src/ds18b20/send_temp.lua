--
--
--
--

function send_data(t, addr)
   local json = require("cjson")
   local devid = string.format("%02X-%02X%02X%02X%02X%02X%02X%02X",
                               addr:byte(1),addr:byte(2),addr:byte(3),addr:byte(4),
                               addr:byte(5),addr:byte(6),addr:byte(7),addr:byte(8))
   
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
