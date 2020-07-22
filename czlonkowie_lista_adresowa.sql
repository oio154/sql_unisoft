select distinct
-- KLIENT
k.bkklient_id,
k.bkklient_nazwa as Nazwisko_imie,
-- ADRES KLIENTA
k.bkklient_kod_pocztowy,
(select bkkraj_nazwa from bkkraj where bkkraj_id = k.bkkraj_id) as klient_kraj,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkmiasto_id) as klient_miasto,
(select bkgmina_nazwa from bkgmina where bkgmina_id = k.bkgmina_id) as klient_gmina,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkpoczta_id) as klient_poczta,
(select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id) as klient_ulica,
k.bkklient_numer_posesji || ' / ' || k.BKKLIENT_NUMER_LOKALU as klient_nr_posesji,
/*
-- Czy adres klienta w naszych zasobach
Porównujemy tutaj 2 adresy (stringiem) z bk oraz z inf. Niekiedy te adresy nie sa zgodne
ze wzglêdu na ró¿ne nazwy ulic.
*/
--jacek.admorcount(k.bkklient_id) as adm,
getADM((select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkmiasto_id), (select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id), k.bkklient_numer_posesji ) as test_adm3,
replace(((select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id) ||k.bkklient_numer_posesji),' ','') as test_adr1,
case when upper(replace(((select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id) || ' ' ||k.bkklient_numer_posesji),' ','')) in 
                                                  (select 
                                                  upper(replace((select infklatka_nazwa from infklatka where infklatka_id=p14.infklatka_id),' ',''))
                                                  from infpunkt p14) 
  then 1
  else 0
  end as test_adr_kli,
-- ADRES EMAIL (e-mail)
jacek.getemail(k.bkklient_id) as email,
-- ADRES KORESP. KLIENTA
(select bkkraj_nazwa from bkkraj where bkkraj_id = k.BKKORESP_KRAJ_ID) as koresp_kraj,
k.BKKORESP_KOD_POCZTOWY, 
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkkoresp_miasto_id) as koresp_miasto,
(select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkkoresp_miasto_id) as koresp_poczta,
(select bkulica_nazwa from bkulica where bkulica_id = k.bkkoresp_ulica_id) as koresp_ulica,
k.BKKORESP_NUMER_POSESJI || ' / ' || k.BKKORESP_NUMER_LOKALU as koresp_posesja
from bkklient k
--tylko czlonkowie
inner join (select * from czlczlonek where czlgrupa_id in (62,64)) czl on czl.bkklient_id = k.bkklient_id --11541
--and ROWNUM<30 --dev
--and jacek.getADM((select bkmiasto_nazwa from bkmiasto where bkmiasto_id = k.bkmiasto_id), (select bkulica_nazwa from bkulica where bkulica_id = k.bkulica_id), k.bkklient_numer_posesji ) not in ('TS','TP','TR','TC','TZ','TK') --dev
