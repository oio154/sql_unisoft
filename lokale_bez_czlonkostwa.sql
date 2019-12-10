





select 
 ip.infpunkt_id,
 ip.infpunkt_symbol,
 jacek.wlasnosc_wdacie(ip.infpunkt_symbol, jacek.dzis()) as wl,
 pk.bkklient_id
from infpunkt ip
left outer join infpunktklient pk on pk.infpunkt_id = ip.infpunkt_id
where jacek.wdacie(ip.infpunkt_data_pocz, ip.infpunkt_data_konc, jacek.dzis())=1
and ip.inflokal_id is not null -- tylko mieszkania