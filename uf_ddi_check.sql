CREATE OR REPLACE FUNCTION "public"."uf_ddi_check"("drugastr" varchar, "drugb" varchar=''::character varying)
  RETURNS TABLE("drug1_name" varchar, "drug1_element" varchar, "drug1_category" varchar, "drug1_inscode" varchar, "drug2_name" varchar, "drug2_element" varchar, "drug2_category" varchar, "drug2_inscode" varchar, "ddi_no" int4, "risk" varchar, "summary" varchar, "severity" varchar, "onset" varchar, "reliability" varchar, "management" varchar, "csummary" varchar, "cmanagement" varchar) AS $BODY$
DECLARE splitter VARCHAR(10);
DECLARE splitterlength INT;
declare i int;
declare cnt int;
DECLARE var_r record;
BEGIN
	DROP TABLE IF EXISTS RTN;
	DROP TABLE IF EXISTS rtn_tmp;
	DROP TABLE IF EXISTS arrDrugA;
	DROP TABLE IF EXISTS arrDrugB;
	
	create TEMP TABLE rtn
	(
		drug1_name		varchar(200),
		drug1_element	varchar(100),
		drug1_category	varchar(100),
		drug1_inscode	varchar(10),
		drug2_name		varchar(200),
		drug2_element	varchar(100),
		drug2_category	varchar(100),
		drug2_inscode	varchar(10),
		ddi_no			int,
		risk			varchar(5),
		summary			varchar(600),
		severity		varchar(5),
		onset			varchar(5),
		reliability		varchar(5),
		management		varchar(2300),
		csummary		varchar(1200),
		cmanagement		varchar(4000)
	); 
   	create TEMP TABLE rtn_tmp
	(
		seq			serial,
		drug1_name		varchar(200),
		drug1_element	varchar(100),
		drug1_category	varchar(100),
		drug1_inscode	varchar(10),
		drug2_name		varchar(200),
		drug2_element	varchar(100),
		drug2_category	varchar(100),
		drug2_inscode	varchar(10),
		ddi_no			int
	);

   	create TEMP TABLE arrDrugA
	(
	  seq			serial,
	  mark_flag		char(1),
	  ins_code		varchar(10),
	  drug_ename	varchar(120) Null,
	  compound_flag	varchar(1) Null,
	  ele_name_org	varchar(100) Null,
	  ele_name		varchar(100) Null,
	  ATC_Code		varchar(8),
	  drug_no		int
	);

   	create TEMP TABLE arrDrugB
	( 
	  seq			serial,
	  mark_flag		char(1),
	  ins_code		varchar(10),
	  drug_ename	varchar(120) Null,
	  compound_flag	varchar(1) Null,
	  ele_name_org	varchar(100) Null,
	  ele_name		varchar(100) Null,
	  ATC_Code		varchar(8),
	  drug_no		int
	); 

-- split DrugAstr iwith splitter = '/' to arrDrugA
	splitter := '/';
	splitterlength := length(splitter) + 1;
	-- splitterlength := length(splitter);

	WITH RECURSIVE Split AS
	(
		SELECT
			1 AS startidx,
			strpos(concat(DrugAstr,splitter), splitter) - 1 AS endidx

		UNION ALL

		SELECT
			s.endidx + splitterlength,  
			s.endidx + splitterlength + strpos(substring(concat(DrugAstr,splitter), s.endidx + 2), splitter) - 2
		FROM Split s 
		WHERE strpos(substring(concat(DrugAstr,splitter), s.endidx + 2), splitter) > 0
	)
	insert into arrDrugA(ins_code, mark_flag)
	select substring(DrugAstr from startidx for endidx-startidx+1), '0' from split ;
	-- select substring(DrugAstr from startidx for endidx), '0' from split;

	-- get drug_ename, element_name from drug_basic_v2
	-- update arrDrugA a
	--    set a.drug_ename = b.drug_ename,
	--        a.ele_name_org = b.element_name,
	--        a.ATC_Code = b.atc_code,
	--        a.compound_flag = b.compound_flag
	--   from drug_basic_v2 b
	--  where a.ins_code = b.drug_code;

	update arrDrugA a
	   set (drug_ename, ele_name_org, ATC_Code, compound_flag)
	   = (b.drug_ename, b.element_name, b."ATC_Code", b.compound_flag)
	  from drug_basic_v2 b
	 where a.ins_code = b.drug_code;

	--  -- 排除ATC_Code 'D','S'開頭者, delete the ATC_Code that first character be start from 'D','S'
	delete from arrDrugA where substring(arrDrugA.ATC_Code from 1 for 1) in ('D', 'S') ;

	-- -- 產生複方的成分1, 
	-- -- get compound 1~4 drug record by check drug_basic_v2.element_name_1 ~5  whether exist
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_1, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and a.mark_flag = '0'
	       and length(b.element_name_1) > 0;
		   
	-- -- 產生複方的成分2
	-- -- get compound 2 drug record by check drug_basic_v2.element_name_2  whether exist
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_2, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and a.mark_flag = '0'
	       and length(b.element_name_2) > 0;

	-- -- 產生複方的成分3
	-- -- get compound 3 drug record by check drug_basic_v2.element_name_3  whether exist	
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_3, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and a.mark_flag = '0'
	       and length(b.element_name_3) > 0;
	
	-- -- 產生複方的成分3
	-- -- get compound 3 drug record by check drug_basic_v2.element_name_3  whether exist	
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_3, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and a.mark_flag = '0'
	       and length(b.element_name_3) > 0;

	-- -- 產生複方的成分4
	-- -- get compound 4 drug record by check drug_basic_v2.element_name_4  whether exist	
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_4, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and length(b.element_name_4) > 0;
		   
	-- -- 產生複方的成分5
	-- -- get compound 5 drug record by check drug_basic_v2.element_name_5  whether exist	
	insert into arrDrugA(ins_code, drug_ename, ele_name_org, compound_flag)
	select a.ins_code, a.drug_ename, b.element_name_5, a.compound_flag
	  from arrDrugA a, drug_basic_v2 b
	 where a.ins_code = b.drug_code
	       and a.compound_flag = 'Y'
	       and a.mark_flag = '0'
	       and length(b.element_name_5) > 0;

	-- -- update ele_name
	update arrDrugA a
	   set ele_name = (case when strpos(a.ele_name_org, '(') > 0 then substring(a.ele_name_org from 1 for strpos(a.ele_name_org, '(') - 1)
	                       else a.ele_name_org end) ;
	-- --   from arrDrugA a ;

	-- -- get drug_no from CLM_DDI_DRUG
	update arrDrugA a
	   set drug_no = b."Drug_NO"
	  from CLM_DDI_DRUG b 
	 where LOWER(a.ele_name) = LOWER(b."Drug_Name" );

	-- insert into tmp_arr select * from arrDrugA; 

	-- if DrugB have value then, proc DrugB
	if RTrim(DrugB) <> '' then
		insert into arrDrugB(ins_code, mark_flag) values (DrugB, '0') ;
	-- 	-- get drug_ename, element_name
		update arrDrugB a
		   set drug_ename = b.drug_ename,
	           ele_name_org = b.element_name,
	           ATC_Code = b."ATC_Code",
	           compound_flag = b.compound_flag
		  from drug_basic_v2 b
		 where a.ins_code = b.drug_code ;
		
		delete from arrDrugB where substring(atc_code from 1 for 1) in ('D', 'S') ;
		
	-- 	-- 產生複方的成分1
		insert into arrDrugB(ins_code, drug_ename, ele_name_org, compound_flag)
		select a.ins_code, a.drug_ename, b.element_name_1, a.compound_flag
		  from arrDrugB a, drug_basic_v2 b
		 where a.ins_code = b.drug_code
			   and a.compound_flag = 'Y'
			   and a.mark_flag = '0'
			   and length(b.element_name_1) > 0;
	
	-- 	-- 產生複方的成分2
		insert into arrDrugB(ins_code, drug_ename, ele_name_org, compound_flag)
		select a.ins_code, a.drug_ename, b.element_name_2, a.compound_flag
		  from arrDrugB a, drug_basic_v2 b
		 where a.ins_code = b.drug_code
		       and a.compound_flag = 'Y'
		       and a.mark_flag = '0'
		       and length(b.element_name_2) > 0;
	       
	-- 	-- 產生複方的成分3
		insert into arrDrugB(ins_code, drug_ename, ele_name_org, compound_flag)
		select a.ins_code, a.drug_ename, b.element_name_3, a.compound_flag
		  from arrDrugB a, drug_basic_v2 b
		 where a.ins_code = b.drug_code
		       and a.compound_flag = 'Y'
		       and a.mark_flag = '0'
		       and length(b.element_name_3) > 0;
	       
	-- 	-- 產生複方的成分4
		insert into arrDrugB(ins_code, drug_ename, ele_name_org, compound_flag)
		select a.ins_code, a.drug_ename, b.element_name_4, a.compound_flag
		  from arrDrugB a, drug_basic_v2 b
		 where a.ins_code = b.drug_code
		       and a.compound_flag = 'Y'
		       and a.mark_flag = '0'
		       and length(b.element_name_4) > 0;
	
	-- 	-- 產生複方的成分5
		insert into arrDrugB(ins_code, drug_ename, ele_name_org, compound_flag)
		select a.ins_code, a.drug_ename, b.element_name_5, a.compound_flag
		  from arrDrugB a, drug_basic_v2 b
		 where a.ins_code = b.drug_code
		       and a.compound_flag = 'Y'
		       and a.mark_flag = '0'
		       and length(b.element_name_5) > 0;
	       
	-- 	-- get ele_name
		update arrDrugB a
		   set ele_name = (case when strpos(a.ele_name_org, '(') > 0 then substring(a.ele_name_org from 1 for strpos(a.ele_name_org, '(') - 1)
	                       else a.ele_name_org end) ;
	-- 	--   from arrDrugB a ;
		
	-- 	-- get drug_no
		update arrDrugB a
		   set drug_no = b."Drug_NO"
		  from CLM_DDI_DRUG b 
		 where a.ele_name = b."Drug_Name" ;
	END IF;

	-- -- DrugB 
	-- -- 1. DrugB有值則與DrugA進行配對檢查
	-- -- 2. DrugB無值則DrugA進行檢查
	-- -- 1. if DrugB have value, then combine with DrugA parameter to check DDI
	-- -- 2. if DrugB have not value, the direct using DrugA parameter to check DDI
	if RTrim(DrugB) <> '' then
	-- 	--1. if DrugB have value, then combine with DrugA parameter to check DDI
		insert into rtn_tmp(drug1_name, drug1_element, drug1_category, drug1_inscode, 
		                     drug2_name, drug2_element, drug2_category, drug2_inscode, ddi_no)
		select da.drug_ename, da.ele_name, g1."Category_Name", da.ins_code,
		       db.drug_ename, db.ele_name, g2."Category_Name", db.ins_code, r."DDI_No"
		  from CLM_DDI_SET r,
		       CLM_DDI_CATEGORY_XREF b1,
			   CLM_DDI_CATEGORY_XREF b2,
			   CLM_DDI_CATEGORY g1,
			   CLM_DDI_CATEGORY g2,
		       arrDrugB da,
		       arrDrugA db
		 where r."Drug1_No" = b1."Category_No" 
		       and r."Drug2_No" = b2."Category_No"
		       and b1."Drug_NO" = da.drug_no 
		       and b2."Drug_NO" = db.drug_no
		       and g1."Category_No" = b1."Category_No"
		       and g2."Category_No" = b2."Category_No"
		       and da.drug_ename <> db.drug_ename ;
		
		insert into rtn_tmp(drug1_name, drug1_element, drug1_category, drug1_inscode,
		                     drug2_name, drug2_element, drug2_category, drug2_inscode, ddi_no)
		select da.drug_ename, da.ele_name, g1."Category_Name", da.ins_code,
		       db.drug_ename, db.ele_name, g2."Category_Name", db.ins_code, r."DDI_No"
		  from CLM_DDI_SET r,
		       CLM_DDI_CATEGORY_XREF b1,
			   CLM_DDI_CATEGORY_XREF b2,
			   CLM_DDI_CATEGORY g1,
			   CLM_DDI_CATEGORY g2,
		       arrDrugB db,
		       arrDrugA da
		 where r."Drug1_No" = b1."Category_No" 
		       and r."Drug2_No" = b2."Category_No"
		       and b1."Drug_NO" = da.drug_no 
		       and b2."Drug_NO" = db.drug_no
		       and g1."Category_No" = b1."Category_No"
		       and g2."Category_No" = b2."Category_No"
		       and da.drug_ename <> db.drug_ename ;
	else
		-- 2. if DrugB have not value, the direct using DrugA parameter to check DDI
		insert into rtn_tmp(drug1_name, drug1_element, drug1_category, drug1_inscode,
		                     drug2_name, drug2_element, drug2_category, drug2_inscode, ddi_no)
		select da.drug_ename, da.ele_name, g1."Category_Name", da.ins_code,
		       db.drug_ename, db.ele_name, g2."Category_Name", db.ins_code, r."DDI_No"
		  from CLM_DDI_SET r,
		       CLM_DDI_CATEGORY_XREF b1,
			   CLM_DDI_CATEGORY_XREF b2,
			   CLM_DDI_CATEGORY g1,
			   CLM_DDI_CATEGORY g2,
		       arrDrugA da,
		       arrDrugA db
		 where r."Drug1_No" = b1."Category_No" 
		       and r."Drug2_No" = b2."Category_No"
		       and b1."Drug_NO" = da.drug_no 
		       and b2."Drug_NO" = db.drug_no
		       and g1."Category_No" = b1."Category_No"
		       and g2."Category_No" = b2."Category_No"
		       and da.ins_code <> db.ins_code ;
		       
	End if;

	-- 剔除重複ddi no做輸出
	-- delete rtn_tmp duplicate ddi_no record

	-- insert into tmp_rtn SELECT * FROM rtn_tmp;
	-- RETURN QUERY SELECT * FROM rtn_tmp;
	
	select max(rtn_tmp.seq) into i from rtn_tmp;

	while (i > 0) loop
		select count(a.seq) into cnt
		  from rtn_tmp a, rtn_tmp b
		 where a.seq < i
		       and a.drug1_name = b.drug2_name
		       and a.drug2_name = b.drug1_name
		       and a.ddi_no = b.ddi_no
		       and b.seq = i ;
		
		if cnt > 0 then
			delete from rtn_tmp where rtn_tmp.seq = i ;
		end if;
		i:=i-1;
	end loop;

	-- insert record to rtn that get from CLM_DDI_SET join rtn_tmp data 	
	insert into rtn(drug1_name, drug2_name, drug1_element, drug2_element, drug1_category, drug2_category,
	                 drug1_inscode, drug2_inscode,
	                 ddi_no, risk, summary, severity, onset, reliability, management,
	                 csummary, cmanagement)
	select da.drug1_name, da.drug2_name, da.drug1_element, da.drug2_element, da.drug1_category, da.drug2_category,
	       da.drug1_inscode, da.drug2_inscode,
	       da.ddi_no, r."Risk", r."Summary", r."Severity", r."Onset", r."Reliability", r."Management", r."CSummary", r."CManagement"
	  from CLM_DDI_SET r,
	       rtn_tmp da
	where r."DDI_No" = da.ddi_no;
	
	RETURN QUERY SELECT * FROM rtn;
	-- DROP TABLE RTN;
	-- DROP TABLE rtn_tmp;
	-- DROP TABLE arrDrugA;
	-- DROP TABLE arrDrugB;
	RETURN;
	-- FOR var_r IN(SELECT * FROM rtn)  
	-- LOOP
	-- 	RETURN NEXT;
	-- END LOOP;
	-- RETURN;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000