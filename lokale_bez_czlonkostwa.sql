


/*

mamy na razie punkty z klientami,
dolozono czonków i ich grupê w czyczl jest 1 je¿eli ktoœ jest w tabeli czonków oraz ma grupê czlonek lub czonek-firma
--15245  Rows
Ograniczono do wasnoœci s i l
*/


select infpunkt_symbol, sum(czyczl) as ileczl from
(
    with czl as (select * from czlczlonek)
    select 
     ip.infpunkt_id,
     ip.infpunkt_symbol,
     --jacek.wlasnosc_wdacie(ip.infpunkt_symbol, jacek.dzis()) as wl,
     pk.bkklient_id,
     case when czl.czlgrupa_id in (62,64) then 1 else 0 end as czyczl
     --czl.czlgrupa_id
    from infpunkt ip
    left outer join infpunktklient pk on pk.infpunkt_id = ip.infpunkt_id
    left outer join czl  on  czl.bkklient_id = pk.bkklient_id
    where jacek.wdacie(ip.infpunkt_data_pocz, ip.infpunkt_data_konc, jacek.dzis())=1
    and ip.inflokal_id is not null -- tylko mieszkania
)
where jacek.wlasnosc_wdacie(infpunkt_symbol, jacek.dzis()) in ('S','L')
group by infpunkt_symbol
having sum(czyczl)<1