select 
 pkt.infpunkt_id, 
 infpunkt_symbol, 
 pkt.infnieruchomosc_id,
 n.infnieruchomosc_symbol,
 n.infnieruchomosc_nazwa, 
 infpunkt_nazwa,
 mirka.adres || ' / ' || mirka.nr as mirka_adres,
 klatka.infklatka_nazwa,
 lok.inflokal_numer,
 bkklient.bkklient_id,
 bkklient.bkklient_symbol,
 bkklient.bkklient_nazwa,
 jacek.wlasnosc_wdacie(pkt.infpunkt_symbol,dzis()) as wlasnosc,
 ppow.POW_UZ,
 nvl(pudz.UDZIAL,0) as udzial,
 case when pudz.UDZIAL is null then 'BU' else ' ' end as czy_udzial,
 mirka.nalezna
from( --11719

        select * from infpunkt 
        where 1=1
        and inflokal_id is not null
        and wdacie(infpunkt_data_pocz,infpunkt_data_konc, dzis())=1
        
        union all
        
        select * from infpunkt 
        where 1=1
        and infzasob_id is not null
        and wdacie(infpunkt_data_pocz,infpunkt_data_konc, dzis())=1
)pkt

left outer join (
        select infpunkt_id, ip.infpunktparam_wartosc as POW_UZ from infpunktparam ip
        where wdacie(ip.INFPUNKTPARAM_DATA_POCZ, ip.INFPUNKTPARAM_DATA_KONC, dzis())=1
        and ip.infparametr_id = 901
)ppow  on ppow.infpunkt_id = pkt.infpunkt_id

left outer join (
        select infpunkt_id, ip.infpunktparam_wartosc as UDZIAL from infpunktparam ip
        where wdacie(ip.INFPUNKTPARAM_DATA_POCZ, ip.INFPUNKTPARAM_DATA_KONC, dzis())=1
        and ip.infparametr_id = 2622
)pudz  on pudz.infpunkt_id = pkt.infpunkt_id

left outer join infnieruchomosc n on n.infnieruchomosc_id = pkt.infnieruchomosc_id

left outer join bkklient on pkt.bkklient_id=bkklient.bkklient_id

left outer join jacek.mirka on mirka.infpunkt_id=pkt.infpunkt_id

left outer join inflokal lok on lok.inflokal_id = pkt.inflokal_id

left outer join infklatka klatka on klatka.infklatka_id=lok.infklatka_id

order by infnieruchomosc_symbol, infklatka_nazwa, 
case when replace(translate(trim(inflokal_numer),'0123456789','0'),'0','') is null then to_number(inflokal_numer) end,
inflokal_numer

-- where n.infnieruchomosc_symbol='0526';