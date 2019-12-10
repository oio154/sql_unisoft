select distinct czlstatus_sl_nazwa, czlgrupa_nazwa from
   ( select 
        cz.czlczlonek_id,
        lastST.czlstatus_sl_id,
        cz.czlgrupa_id,
        czlstatus_sl.CZLSTATUS_SL_NAZWA,
        czlgrupa.czlgrupa_nazwa
    from czlczlonek cz --19212
    left outer join (select czlczlonek_id, czlstatus_sl_id from czlstatus st1 where czlstatus_data_au = (select max(st2.czlstatus_data_au) from czlstatus st2 where st2.czlczlonek_id=st1.czlczlonek_id)) lastST
        on lastst.czlczlonek_id=cz.czlczlonek_id
    left outer join czlstatus_sl on czlstatus_sl.CZLSTATUS_SL_ID = lastST.CZLSTATUS_SL_ID
    left outer join czlgrupa on czlgrupa.czlgrupa_id = cz.czlgrupa_id
   )sttecz
;






