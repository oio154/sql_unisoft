

select * from bkklient;

select * from infpunktklient;


select * from inflokal;

select * from infklatka;
select * from infbudynek;

select * from infpunkt;
select * from infklatka;
select infklatka_nazwa, infulica_nazwa from infklatka left outer join infulica on infklatka.infulica_id=infulica.infulica_id;


select 
 --bk.bkklient_nazwa, 
 REPLACE(  REPLACE(  REPLACE(REPLACE(bk.bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-') dev4,
 SUBSTR(    REPLACE(  REPLACE(  REPLACE(REPLACE(bk.bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-') , 1 , INSTR(REPLACE(  REPLACE(  REPLACE(REPLACE(bk.bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-'), ' ')-1      ) nazwisko,
 SUBSTR(    REPLACE(  REPLACE(  REPLACE(REPLACE(bk.bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-') ,  INSTR(REPLACE(  REPLACE(  REPLACE(REPLACE(bk.bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-'), ' ')+1 ,400     ) imie,
 case when bk.bkklient_nip is not null and bk.bkklient_pesel is null then '1' else '' end as dev_9,
 nvl(bk.bkklient_pesel,'0') as pesel ,
 bud.infbudynek_kod_pocztowy,
 (select symbol from jacek.teryt_ul where nazwa like SUBSTR(ul.infulica_nazwa, 10, 266)) as teryt_ul,
 SUBSTR(ul.infulica_nazwa, 10, 266) as ulica,
 klatka.infklatka_nazwa as dev1,
 SUBSTR(klatka.infklatka_nazwa, LENGTH( SUBSTR(ul.infulica_nazwa, 10, 266) )+2 , 300) as klatka_numer,
 lok.inflokal_numer,
 case when jacek.WLASNOSC_WDACIE(pk.infpunkt_symbol, jacek.dzis()) = 'L' then 2
      when jacek.WLASNOSC_WDACIE(pk.infpunkt_symbol, jacek.dzis()) = 'S' then 1
      else 1000
      end as wlasnosc
from bkklient bk
inner join infpunktklient ik on ik.bkklient_id=bk.bkklient_id
inner join (select * from infpunkt where jacek.wdacie(infpunkt_data_pocz,infpunkt_data_konc,jacek.dzis() )=1 and inflokal_id is not null ) pk on pk.infpunkt_id=ik.infpunkt_id --17504, 15252
left outer join infklatka klatka on klatka.infklatka_id=pk.infklatka_id
left outer join infbudynek bud on bud.infbudynek_id=pk.infbudynek_id
left outer join infulica ul on ul.infulica_id=klatka.infulica_id
left outer join inflokal lok on lok.inflokal_id=pk.inflokal_id  --L,S
where jacek.WLASNOSC_WDACIE(pk.infpunkt_symbol, jacek.dzis()) in ('L','S')

;


create table teryt_ul (symbol number(10), cecha varchar(20), nazwa varchar(128));


select 
REPLACE(  REPLACE(  REPLACE(REPLACE(bkklient_nazwa,'  ',' '),' - ','-') , ' -', '-' ) , '- ','-')
from bkklient where 1=1
and bkklient_nazwa like '%-%'







;



select bkklient_pesel, bkklient_nip from bkklient;




