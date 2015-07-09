--
-- Initial Wifi setup
--

SSID = "<Wifi-SID>"
SSID_PASSWORD = "<password>"

wifi.setmode(wifi.STATION)
wifi.sta.config(SSID,SSID_PASSWORD)
wifi.sta.autoconnect(1)
