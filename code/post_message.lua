--
-- post message to remote host
--
function post_message(ip, port, msg)
   local con=net.createConnection(net.TCP,0)
   con:on("receive", function(con, c) print(c) end)
   con:connect(port,ip)
   con:send("POST /data HTTP/1.1\r\n")
   con:send("Content-Type: application/json\r\n")
   con:send("Accept: application/json\r\n")
   con:send("content-length:"..string.len(msg).."\r\n")
   con:send("\r\n")
   con:send(msg)
   con:send("\r\n")
   con:on("sent",function(conn)
             conn:close()
   end
   )
end
