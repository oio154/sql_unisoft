select distinct
-- KLIENT
k.bkklient_nazwa as Nazwisko_imie,
-- ADRES KLIENTA
k.bkklient_kod_pocztowy,
(select bkkraj_nazwa from bkkraj where bkkraj_id = k.bkkraj_id) as klient_kraj,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkmiasto_id) as klient_miasto,
(select bkgmina_nazwa from bkgmina where bkgmina_id = k.bkgmina_id) as klient_gmina,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkpoczta_id) as klient_poczta,
(select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id) as klient_ulica,
k.bkklient_numer_posesji || ' / ' || k.BKKLIENT_NUMER_LOKALU as klient_nr_posesji,
-- ADRES KORESP. KLIENTA
(select bkkraj_nazwa from bkkraj where bkkraj_id = k.BKKORESP_KRAJ_ID) as koresp_kraj,
k.BKKORESP_KOD_POCZTOWY, 
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkkoresp_miasto_id) as koresp_miasto,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkkoresp_miasto_id) as koresp_poczta,
(select bkulica_nazwa from bkulica where bkulica_id = k.bkkoresp_ulica_id) as koresp_ulica,
k.BKKORESP_NUMER_POSESJI || ' / ' || k.BKKORESP_NUMER_LOKALU as koresp_posesja
-- ADRES LOKALU 
/*case 
  when (p.inflokal_id is not null and p.infzasob_id is null) then 'MIESZ'
  when (p.inflokal_id is null and p.infzasob_id is not null) then 'UZYTK'
  else 'WOW !!!' end as typ_lokalu,
(select infrejon_nazwa from infrejon where p.infrejon_id = infrejon_id) as p_rejon,
p.infpunkt_adres,
(select infklatka_nazwa from infklatka where infklatka_id = p.infklatka_id) p_klatka
*/
from bkklient k --33206
inner join infpunktklient pk on k.bkklient_id = pk.bkklient_id --27950
left outer join infpunkt p on p.infpunkt_id = pk.infpunkt_id
inner join (select * from czlczlonek where czlgrupa_id in (62,64)) czl on czl.bkklient_id = k.bkklient_id
where jacek.wdacie(p.infpunkt_data_pocz,p.infpunkt_data_konc,jacek.dzis())=1 --17505