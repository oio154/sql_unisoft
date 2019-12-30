

select SUM(udzial), infnieruchomosc_symbol from
(
select 
 pkt.infpunkt_id, 
 infpunkt_symbol, 
 pkt.infnieruchomosc_id,
 n.infnieruchomosc_symbol,
 n.infnieruchomosc_nazwa, 
 infpunkt_nazwa,
 ppow.POW_UZ,
 nvl(pudz.UDZIAL,0) as udzial,
 case when pudz.UDZIAL is null then 'BU' else ' ' end as czy_udzial
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
)


--powiazanie z zakresem word - czynsze

where 1=1 
/* and infnieruchomosc_symbol in (0001,
0002,
0003,
0004,
0007,
0009,
0010,
0012,
0013,
0014,
0100,
0101,
0103,
0104,
0105,
0106,
0107,
0108,
0109,
0110,
0128,
0129,
0131,
0132,
0141,
0142,
0143,
0144,
0145,
0200,
0224,
0225,
0228,
0231,
0232,
0234,
0235,
0239,
0240,
0242,
0300,
0301,
0302,
0310,
0311,
0312,
0314,
0400,
0432,
0433,
0434,
0500,
0501,
0502 ,
0503,
0504,
0505,
0506,
0507,
0509,
0510,
0513,
0515,
0516,
0517,
0521,
0524,
0525,
0526,
0527,
0528,
0529,
0531,
0534,
0535,
0536,
0537,
0539,
0540,
0541,
0542,
0543,
0544,
0546,
0547,
0548,
0549,
0561,
0562,
0563,
0564,
0569,
0570,
0571,
0572,
0573,
0574,
0575)

*/

group by infnieruchomosc_symbol