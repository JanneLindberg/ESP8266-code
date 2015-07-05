--

t=require("ds18b20")
t.setup(3)

function send_temp_data()
   local addrs=t.addrs()

   for i=1,#addrs do
      local devid = string.format("%02X-%02X%02X%02X%02X%02X%02X%02X",
                                  addrs[i]:byte(1),addrs[i]:byte(2),addrs[i]:byte(3),addrs[i]:byte(4),
                                  addrs[i]:byte(5),addrs[i]:byte(6),addrs[i]:byte(7),addrs[i]:byte(8))
      
      local msg = {}
      local p = {}

      p["value"] = tostring(t.read(addrs[i],t.C))      
      msg["dev-id"] = "dev."..devid..".temp"
      msg["payload"] = p
      local msg1 = json.encode(msg)
      msg=nil
      p=nil
      devid=nil
      
      print(msg1)
      post("["..msg1.."]")
      msg=nil
   end
end
