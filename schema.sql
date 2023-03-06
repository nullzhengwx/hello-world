insert into pg_attribute (
	attrelid,attname,atttypid,attstattarget,attlen,attnum,attndims,attcacheoff,atttypmod,attbyval,attstorage,attalign,attnotnull,atthasdef,attisdropped,attislocal,attinhcount,attcollation,attacl,attoptions,attfdwoptions
	)
	select 
	attrelid,'a',atttypid,attstattarget,attlen,attnum+1,attndims,attcacheoff,atttypmod,attbyval,attstorage,attalign,'f','t',attisdropped,attislocal,attinhcount,attcollation,attacl,attoptions,attfdwoptions 
	from pg_attribute where attrelid='address'::regclass and attname='state';


update pg_class set relnatts=relnatts+1 where relname='address';


with t as(select max(attnum) as maxAttNum from pg_attribute where attrelid='address'::regclass)
insert into pg_attrdef(adrelid,adnum,adbin,adsrc) select adrelid,maxAttNum,adbin,adsrc from pg_attrdef,t where adrelid='address'::regclass and adnum=(select attnum from pg_attribute where attrelid ='address'::regclass and attname='state');
